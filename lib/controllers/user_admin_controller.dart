import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/models/role.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAdminController extends GetxController {
  late SharedPreferences pref;
  String token = '-1';

  Rx<User> user = User().obs;

  RxList<User> userList = <User>[].obs;
  RxList<Role> roleList = <Role>[].obs;

  RxInt dropDownValue = 3.obs;
  RxList<DropdownMenuItem<int>> dropDownRoleList =
      <DropdownMenuItem<int>>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getUsers();
    getroles();

  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }

  getUsers() async {
    await getToken();
    userList.clear();
    try {
      if (token != '-1') {
        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.get(
          '${locallhost}/admin/user/list',
          options: dio.Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            method: 'Get',
            responseType: dio.ResponseType.json,
          ),
        );

        if (response.statusCode! < 300) {
          for (var item in response.data['users']) {
            userList.add(User.fromJson(item));
          }
        }
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما دسترسیی به این عملیات را ندارید.');
        return;
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar('مشکلی در نمایش اطلاعات به وجود آمده.');
      print(e);
    }
  }

  getroles() async {
    await getToken();
    roleList.clear();

    try {
      if (token != '-1') {
        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.get(
          '${locallhost}/admin/roles',
          options: dio.Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            method: 'Get',
            responseType: dio.ResponseType.json,
          ),
        );
        print(response.data['roles']);

        if (response.statusCode! < 300) {
          for (var item in response.data['roles']) {
            roleList.add(Role.fromJson(item));
          }
          for (var item in roleList) {
            var dropDownItem = DropdownMenuItem(
              value: item.id,
              child: Text(item.name!),
            );
            dropDownRoleList.add(dropDownItem);
          }
        }
      }
    } catch (e, s) {
      // StaticMethodes.unSuccesSnackBar('مشکلی در نمایش اطلاعات به وجود آمده.');
      print(e);
    }
  }

  addUser() async {
    reset();
    await getToken();
    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اچازه دسترسی به این قسمت را ندارید');
    } else {
      try {
        String name = nameController.text;
        String email = emailController.text;
        String password = passController.text;
        int roleId = dropDownValue.value;


        Map<String, dynamic> newMap = {};
        newMap['name'] = name;
        newMap['email'] = email;
        newMap['password'] = password;
        newMap['role_id'] = roleId;
        if (StaticMethodes.validateName(name, 'نام کاربر') &&
            StaticMethodes.validateEmail(email) &&
            StaticMethodes.validatePassword(password)) {
          dio.Dio myDio = dio.Dio();
          dio.Response response = await myDio.post(
            '${locallhost}/admin/user/insert',
            data: newMap,
            options: dio.Options(
                headers: {
                  HttpHeaders.authorizationHeader: 'Bearer $token',
                },
                method: 'POST',
                responseType: dio.ResponseType.json,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                }),
          );


          if (response.data!='') {
            StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ذخیره شد.');

          reset();
        }
        } else {
          StaticMethodes.errorSnackBar('خطا', 'ایمیل تکراری می باشد.');
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar('مشکلی در ذخیره اطلاعات به وجود آمده.');
      }
    }
    getUsers();
  }

  deletUser(int id)async{

  }

  editActiveUser(int userId) async {
    await getToken();

    if (token != '-1') {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/activeUser/${userId}',
        options: dio.Options(
          method: 'Get',
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
          responseType: dio.ResponseType.json,
        ),
      );
      String? pass = pref.getString('password');

      if(response.statusCode! < 300){
        user.value = User.fromJson(response.data['user']);
        nameController.text = user.value.name!;
        emailController.text = user.value.email!;
        telController.text = user.value.tel!;
         passController.text = pass!;
         confirmPassController.text = pass!;
        String image = user.value.image!;
        Get.toNamed(AppRouts.userAdminProfileScreen , arguments: image);
      }

    }
  }

  reset(){
    nameController.clear();
    emailController.clear();
    passController.clear();
    confirmPassController.clear();
  }
}

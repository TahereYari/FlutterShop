import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/models/address.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

class AddressController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController ostanController = TextEditingController();
  TextEditingController shahahrController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  RxList<Address> addressList = <Address>[].obs;

  late SharedPreferences pref;
  String token = '-1';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getAddress();
  }


  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
  }

  addAddress() async{
    await getToken();

    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String name = nameController.text;
      String ostan = ostanController.text;
      String shahr = shahahrController.text;
      String code = codeController.text;
      String tel = telController.text;
      String detail = detailController.text;

      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['ostan'] = ostan;
      newMap['shahr'] = shahr;
      newMap['code'] = code;
      newMap['tel'] = tel;
      newMap['address'] = detail;


      if (StaticMethodes.validateName(detail, 'جزییات آدرس') &&
          StaticMethodes.validateName(tel, 'تلفن')) {

        try {
          dio.Dio myDio = dio.Dio();
          dio.FormData formData = dio.FormData.fromMap(newMap);
          dio.Response response = await myDio.post(
            '${locallhost}/cart/adddressinsert',
            data: formData,
            options: dio.Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              method: 'POST',
              contentType: 'application/json',
              responseType: dio.ResponseType.json,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                }
            ),

          );
          if (response.statusCode!<300) {
            StaticMethodes.SuccesSnackBar('سبد خرید شما با موفقیت ثبت شد.');
          //  Get.find<BasketController>().basket!=null;
            Get.find<BasketController>().basketProductList.clear();
            Get.offAllNamed(AppRouts.firstScreenFront);


            reset();
          } else {
            StaticMethodes.errorSnackBar('خطا', 'لطفا در ورود اطلاعات دقت کنید.');
          }
        } on dio.DioException catch (e, s) {
          print('s');
          print(s);
          print('e');
          print(e);
          StaticMethodes.unSuccesSnackBar('مشکلی در ذخیره اطلاعات به وجود آمده.');
        }
      }
    }
  }

  getAddress()async {
    await getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/cart/adddress',
        options: dio.Options(
          method: 'Get',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: dio.ResponseType.json,
        ),
      );
      print(response.data['address']);


      if (response.statusCode! < 300) {
        for (var item in response.data['address']) {
          addressList.add(
            Address.fromJson(item),
          );
        }
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
        return;
      }
    } catch (e, s) {
      print(s);
      print(e);
    }
  }

  reset(){
    nameController.clear();
    ostanController.clear();
    shahahrController.clear();
    telController.clear();
    codeController.clear();
    detailController.clear();
  }
}
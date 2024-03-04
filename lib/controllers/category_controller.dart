import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/services/app_routs.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController describController = TextEditingController();

  Rx<File> file = File('-1').obs;
  late SharedPreferences pref;
  String token = '-1';
  RxList<Category> categoryList = <Category>[].obs;
  Rx<Category> cat =Category().obs;

  @override
  void onInit() {
    super.onInit();
    getListCategory();
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }

  Future<void> selectImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile _pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery) ??
            XFile('-1');
    if (_pickedImage.path != '-1') {
      file.value = File(_pickedImage.path);
    }
  }

  createCategory() async {
    await getToken();

    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String name = nameController.text;
      String desc = describController.text;

      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['description'] = desc;

      if (StaticMethodes.validateName(name, 'نام دسته بندی') &&
          StaticMethodes.validateName(desc, 'توضیحات')) {
        if (file.value.path == '-1') {
          StaticMethodes.errorSnackBar('خطا', 'لطفا یک تصویر انتخاب کنید');
          return;
        } else {
          newMap['image'] = await dio.MultipartFile.fromFile(file.value.path,
              filename: file.value.path.split('/').last);
        }
        try {
          dio.Dio myDio = dio.Dio();
          dio.FormData formData = dio.FormData.fromMap(newMap);
          dio.Response response = await myDio.post(
            '${locallhost}/admin/category/insert',
            data: formData,
            options: dio.Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              method: 'POST',
              contentType: 'application/json',
              responseType: dio.ResponseType.json,
            ),
          );
          if (response.data != '') {
            StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ذخیره شد.');
            reset();
            categoryList.clear();
            getListCategory();

          } else {
            StaticMethodes.errorSnackBar('خطا', 'نام دسته تکراری می باشد.');
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

  void reset() {
    nameController.clear();
    describController.clear();
    file.value = File('-1');
  }

  getListCategory() async {
    await getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/category/list',
        options: dio.Options(
          method: 'Get',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: dio.ResponseType.json,
        ),
      );

      if (response.statusCode! < 300) {
        for (var item in response.data['data']) {
          categoryList.add(
            Category.fromJson(item),
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

  editCategory(int id) async {

    getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/category/$id',
        options: dio.Options(
          method: 'Get',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: dio.ResponseType.json,
        ),
      );
      if (response.statusCode! < 300) {
        cat.value = Category.fromJson(response.data['category']);
        nameController.text = cat.value.name.toString();
        describController.text = cat.value.description.toString();
      //  file.value = cat.value.image as File;
        String? image =cat.value.image;
        print('image');
        print(image);
        Get.toNamed(AppRouts.updateCategoryScreen,arguments: image);
      }


    } catch (e, s) {
      print(s);
    }
  }

  updateCategory(int id) async {
    await getToken();

    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String name = nameController.text;
      String desc = describController.text;

      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['description'] = desc;

      if (StaticMethodes.validateName(name, 'نام دسته بندی') &&
          StaticMethodes.validateName(desc, 'توضیحات')) {
        if (file.value.path == '-1') {
          StaticMethodes.errorSnackBar('خطا', 'لطفا یک تصویر انتخاب کنید');
          return;
        } else {
          newMap['image'] = await dio.MultipartFile.fromFile(file.value.path,
              filename: file.value.path.split('/').last);
        }
        try {
          dio.Dio myDio = dio.Dio();
          dio.FormData formData = dio.FormData.fromMap(newMap);
          dio.Response response = await myDio.post(
            '${locallhost}/admin/category/update/$id',
            data: formData,
            options: dio.Options(
              headers: {
                HttpHeaders.authorizationHeader:'Bearer $token',
              },
              method: 'POST',
              contentType: 'application/json',
              responseType: dio.ResponseType.json,
            ),
          );
          print('response.statusCode');
          print(response.statusCode);
          if (response.statusCode!<300) {
           StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ویرایش شد.');
           categoryList.clear();
           getListCategory();
           Get.toNamed(AppRouts.categoryList);
            reset();
          } else {
            StaticMethodes.errorSnackBar('خطا', 'نام دسته تکراری می باشد.');
          }
        } on dio.DioException catch (e, s) {
          print('s');
          print(s);
          print('e');
          print(e.message);
        }
      }
    }
  }

  deleteCategory(int id)async {

    await getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/category/delete/$id',
        options: dio.Options(
          method: 'Get',
          headers: {
            HttpHeaders.authorizationHeader:'Bearer $token',
          },
          responseType: dio.ResponseType.json,
        ),
      );
      categoryList.clear();
      getListCategory();
      Get.back();



    } catch (e, s) {
      print(s);
      print(e);
    }
  }
}

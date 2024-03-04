import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController propertiesController = TextEditingController();

  Rx<File> file = File('-1').obs;
  RxList<Category> categorylist = <Category>[].obs;
  RxList<Product> productList = <Product>[].obs;

  Rx<Product> product = Product().obs;

  RxInt dropDownValue = 15.obs;
  RxList<DropdownMenuItem<int>> dropdownCategoryList =
      <DropdownMenuItem<int>>[].obs;

  late SharedPreferences pref;
  String token = '-1';

  @override
  void onInit() {
    super.onInit();
    getCategoryList();
    getProductList();
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

  getCategoryList() async {
    await getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/category/list',
        options: dio.Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          method: 'Get',
          responseType: dio.ResponseType.json,
        ),
      );

      if (response.statusCode! < 300) {
        for (var item in response.data['data']) {
          categorylist.add(Category.fromJson(item));
        }
        for (var item in categorylist) {
          var dropDownItem = DropdownMenuItem(
            value: item.id,
            child: Text(item.name!),
          );

          dropdownCategoryList.add(dropDownItem);
        }
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما دسترسیی به این عملیات را ندارید.');
        return;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  createProduct() async {
    await getToken();


    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اچازه دسترسی به این قسمت را ندارید');
    } else {
      try {
        String name = nameController.text;
        String price = nameController.text;
        String number = numberController.text;
        String propertise = propertiesController.text;
        int categoryId = dropDownValue.value!;

        Map<String, dynamic> newMap = {};

        newMap['name'] = name;
        newMap['price'] = price;
        newMap['number'] = number;
        newMap['propertise'] = propertise;
        newMap['category_id'] = categoryId;

        if (StaticMethodes.validateName(name, 'نام محصول') &&
            StaticMethodes.validateName(price, 'قیمت محصول') &&
            StaticMethodes.validateName(number, 'تعداد محصول')) {
          if (file.value.path == '-1') {
            StaticMethodes.errorSnackBar('خطا', 'لطفا یک تصویر انتخاب کنید');
          } else {
            newMap['image'] = await dio.MultipartFile.fromFile(file.value.path,
                filename: file.value.path.split('/').last);
          }

          dio.Dio myDio = dio.Dio();
          dio.FormData formData = dio.FormData.fromMap(newMap);
          dio.Response response = await myDio.post(
            '${locallhost}/admin/product/insert',
            data: formData,
            options: dio.Options(
                headers: {HttpHeaders.authorizationHeader:'Bearer $token'},
                method: 'POST',
                responseType: dio.ResponseType.json,
                followRedirects: false,
                validateStatus: (status) {
                  return status! < 500;
                }),
          );


         // print(response.data['id']);



          if (response.data != '') {
            StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ذخیره شد.');
            reset();
            print(response.data);

            // Future.delayed(const Duration(seconds: 5),() async{
            //   Get.back;
            // });
          //  Get.toNamed(AppRouts.AddProductPicture ,arguments: id);
          }
        } else {
          StaticMethodes.errorSnackBar('خطا', 'نام محصول تکراری می باشد.');
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar('مشکلی در ذخیره اطلاعات به وجود آمده.');
        //reset();
        // Future.delayed(const Duration(seconds: 5),() async{
        //   Get.back;
        // });
        print(e);
      }
    }
    getProductList();
  }

  getProductList() async {
    await getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/product/list',
        options: dio.Options(
          method: 'Get',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: dio.ResponseType.json,
        ),
      );

      if (response.statusCode! < 300) {
        for (var item in response.data['products']) {
          productList.add(
            Product.fromJson(item),
          );
        }
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
        return;
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar('مشکلی پیش آمده است  دوباره تلاش کنید');
      print(s);
      print(e);
    }
  }

  deleteProduct(int id) async {
    await getToken();
    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/product/delete/$id',
        options: dio.Options(
          method: 'Get',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: dio.ResponseType.json,
        ),
      );
      if (response.statusCode! < 300) {
        productList.clear();
        getProductList();
        Get.back();
      } else {
        StaticMethodes.unSuccesSnackBar(
            'خطایی در انجام عملیات به وجود آمده است.');
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }





  void reset() {
    nameController.clear();
    priceController.clear();
    numberController.clear();
    propertiesController.clear();
    file.value = File('-1');
  }
}

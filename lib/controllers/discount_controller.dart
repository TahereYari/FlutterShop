import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/discount.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

class DiscountController extends GetxController {
  TextEditingController precentController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getProductList();
    scale = 1;
    getDiscountList();
    getDiscountFrontList();
  }

  String fromdate = Jalali.now().toJalaliDateTime();
  String todate = Jalali.now().toJalaliDateTime();
  Jalali? picked;
  Jalali? picked2;

  RxInt dropDownValue = 12.obs;
  RxList<DropdownMenuItem<int>> dropDownProductList =
      <DropdownMenuItem<int>>[].obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<Discount> discountList = <Discount>[].obs;
  RxList<Discount> discountFrontList = <Discount>[].obs;
  late double scale;

  Random random = Random();
  List<Color> color = [
    kLightGreyColor,
    kRedColor,
    kLightRedColor,
    kBlueColor,
    // kGreyColor,
    kGreenColor,
    kLightYellowColor,
    kLightOrangeColor,
    kLightPurpleColor,
    kLightGreenColor,
    kPhirozeColor,
  ];

  late SharedPreferences pref;
  String token = '-1';

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }

  getProductList() async {
    await getToken();

    try {
      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/product/lisall',
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

        for (var item in productList) {
          var dropDownItem = DropdownMenuItem(
            value: item.id,
            child: Text(item.name!),
          );
          dropDownProductList.add(dropDownItem);
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

  addDiscount() async {
    await getToken();

    String y = (picked!.toDateTime().year + 1).toString();
    String m = (picked!.toDateTime().month.toString());
    String d = (picked!.toDateTime().day.toString());
    String dateTimeMiladi1 = '$y-$m-$d';


    String y2 = (picked2!.toDateTime().year + 1).toString() ?? '0';
    String m2 = (picked2!.toDateTime().month.toString()) ?? '0';
    String d2 = (picked2!.toDateTime().day.toString()) ?? '0';
    String dateTimeMiladi2 = '$y2-$m2-$d2';


    if (token != '-1') {
      try {
        int productId = dropDownValue.value;
        String precent = precentController.text;
        String from = fromController.text;
        String to = toController.text;

        Map<String, dynamic> newMap = {};
        newMap['product_id'] = productId;
        newMap['startdate'] = dateTimeMiladi1;
        newMap['enddate'] = dateTimeMiladi2;
        newMap['offprice'] = precent;


        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.post(
          '${locallhost}/admin/offs/insert',
          data: newMap,
          options: dio.Options(
              method: 'POST',
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              responseType: dio.ResponseType.json,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
        );

        print(response.data['diss']);
        if (response.data != '') {
          StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ذخیره شد.');
          reset();
          discountList.clear();
          getDiscountList();
          picked = null;
          picked2 = null;
        } else {
          StaticMethodes.errorSnackBar(
              'خطا', 'برای این محصول قبلا تخفبف اعمال شده است.');
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar('مشکلی در ذخیره اطلاعات به وجود آمده.');
        print(e);
        print(s);
      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    }
  }

  getDiscountList() async {
    await getToken();
    if (token != '-1') {
      try {
        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.get(
          '${locallhost}/admin/offs/list',
          options: dio.Options(
              method: 'Get',
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              responseType: dio.ResponseType.json,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
        );
        if (response.statusCode! < 300) {
          for (var item in response.data['discountProducts']) {
            discountList.add(Discount.fromJson(item));
          }

        } else {
          StaticMethodes.errorSnackBar(
              'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
          return;
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar('مشکلی در نمایش اطلاعات به وجود آمده.');
        print(e);
        print(s);
      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    }
  }

  getDiscountFrontList() async {
      try {
        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.get(
          '${locallhost}/off/preview',
          options: dio.Options(
              method: 'Get',
              headers: {
                HttpHeaders.authorizationHeader:'Bearer $token',
              },
              responseType: dio.ResponseType.json,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }),
        );
        if (response.statusCode! < 300) {
          for (var item in response.data['discounts']) {
            discountFrontList.add(Discount.fromJson(item));
          }
        } else {
          StaticMethodes.errorSnackBar(
              'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
          return;
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar('مشکلی در نمایش اطلاعات به وجود آمده.');
        print(e);
        print(s);
      }

  }



  reset() {
    precentController.clear();
    fromController.clear();
    toController.clear();
  }
}

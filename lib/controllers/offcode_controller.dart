import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/discount.dart';
import 'package:myshop/models/offCode.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dio;

class OffCodeController extends GetxController {
  TextEditingController precentController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();

    scale = 1;
    getOffCodeList();
  }

  String fromdate = Jalali.now().toJalaliDateTime();
  String todate = Jalali.now().toJalaliDateTime();
  Jalali? picked;
  Jalali? picked2;

  RxList<OffCode> offCodeList = <OffCode>[].obs;
  late double scale;

  late SharedPreferences pref;
  String token = '-1';

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }



  getOffCodeList() async {
    await getToken();
    if (token != '-1') {
      try {
        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.get(
          '${locallhost}/admin/offcode/list',
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

        print(response.data['offCodes']['data']);

        if (response.statusCode! < 300) {
          for (var item in response.data['offCodes']['data']) {
            offCodeList.add(OffCode.fromJson(item));
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

  addOffCode() async {
    await getToken();

    String y = (picked!.toDateTime().year + 1).toString();
    String m = (picked!.toDateTime().month.toString());
    String d = (picked!.toDateTime().day.toString());
    String dateTimeMiladi1 = '$y-$m-$d';


    String y2 = (picked2!.toDateTime().year + 1).toString() ?? '0';
    String m2 = (picked2!.toDateTime().month.toString()) ?? '0';
    String d2 = (picked2!.toDateTime().day.toString()) ?? '0';
    String dateTimeMiladi2 = '$y2-$m2-$d2';

    String? error;


    if (token != '-1') {
      try {

        String price = precentController.text;
        String from = fromController.text;
        String to = toController.text;
        String code = codeController.text;

        Map<String, dynamic> newMap = {};

        newMap['satartdate'] = dateTimeMiladi1;
        newMap['enddate'] = dateTimeMiladi2;
        newMap['price'] = price;
        newMap['code'] = code;


        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.post(
          '${locallhost}/admin/offcode/insert',
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


        if (response.data != '') {
          StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ذخیره شد.');
          reset();
          picked = null;
          picked2 = null;
          offCodeList.clear();
          getOffCodeList();

        } else {
          StaticMethodes.errorSnackBar(
              'خطا', ' این کد تخفیف قبلا تعریف شده است.');
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

  reset() {
    precentController.clear();
    fromController.clear();
    toController.clear();
    codeController.clear();
  }
}

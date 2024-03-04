import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addDiscountBasketController extends GetxController {
  TextEditingController codeController = TextEditingController();

  late SharedPreferences pref;
  String token = '-1';
  RxInt newPrice = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
   // newPrice.value =0;
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
  }

  addDiscount(int basket_id) async {
    await getToken();
    newPrice.value =0;

    if (token != '-1') {
      try {
        dio.Dio myDio = dio.Dio();
        String code = codeController.text;
        Map<String, dynamic> newMap = {};
        newMap['discount'] = code;

        dio.Response response = await myDio.post(
          '${locallhost}/cart/adddiscount/${basket_id}',
          data: newMap,
          options: dio.Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            method: 'POST',
            responseType: dio.ResponseType.json,
          ),
        );
        if(response.data['newPrice']!=null){
          newPrice = response.data['newPrice'];
        }

        Get.find<BasketController>().basketProductList.clear();
        Get.find<BasketController>().showPageCart();
        codeController.clear();

        StaticMethodes.unSuccesSnackBar(response.data['error']);
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar(
            'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
        print(e);
        print(s);
      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این قسمت را ندارید.');
    }
  }
}

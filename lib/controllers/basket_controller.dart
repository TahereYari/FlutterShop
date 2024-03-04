import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/basket.dart';
import 'package:myshop/models/basketproduct.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasketController extends GetConnect {
  late SharedPreferences pref;
  String token = '-1';
  int userId = 0;



  Rx<Basket> basket = Basket().obs;


  RxList<BasketProduct> basketProductList = <BasketProduct>[].obs;
  RxList<BasketProduct> mybasketProductList = <BasketProduct>[].obs;
  RxList<Product> productList = <Product>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    //showPageCart();
    getProductList();
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
    // role = pref.getString('role') ?? 'user';
  }

  addToBasket(int productId) async {
    await getToken();
    int? userId = pref.getInt('user_id');

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/cart/insert/${userId}/${productId}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.statusCode! < 300) {
          StaticMethodes.SuccesSnackBar('محصول به سبد خرید شما اضافه شد.');
          return;
        } else {
          StaticMethodes.unSuccesSnackBar(
              'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar(
            'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این قسمت را ندارید.');
    }
  }

  showPageCart() async {
    // scrollController.animateTo(scrollController.position.minScrollExtent,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuad);
  //  basketProductList.clear();
    await getToken();
    userId = pref.getInt('user_id')!;

    if (token != '-1' || userId != 0) {
      try {
        Response response = await get(
          '${locallhost}/cart',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );


        if (response.statusCode! < 300) {
          basket.value = Basket.fromJson(response.body['basket']);
          for (var item in response.body['basketproducts']) {
            basketProductList.add(BasketProduct.fromJson(item));
          }
        } else {
          return;
        }
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

  stepUp(int basket_id, int basketProduct_id) async {
    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/cart/up/${basket_id}/${basketProduct_id}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        basketProductList.clear();
        showPageCart();
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

  stepDown(int basket_id, int basketProduct_id) async {
    await getToken();


    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/cart/down/${basket_id}/${basketProduct_id}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        basketProductList.clear();
        showPageCart();
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

  deleteItemBasket(int basket_id, int basketProduct_id) async {
    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/cart/delete/${basket_id}/${basketProduct_id}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        basketProductList.clear();
        showPageCart();
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

  getProductList() async {
    await getToken();
    productList.clear();
    try {
      Response response = await get(
        '${locallhost}/admin/product/list',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode! < 300) {
        for (var item in response.body['products']) {
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
      print(s);
      print(e);
    }
  }

  checkOut(int address_id)async {
    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/checkout/${address_id}/',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.statusCode! < 300) {
          StaticMethodes.SuccesSnackBar('سبد خرید شما با موفقیت ثبت شد.');
          basketProductList.clear();
          Get.offAllNamed(AppRouts.firstScreenFront);
        //  basket.value!= null;

        } else {
          StaticMethodes.unSuccesSnackBar(
              'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar(
            'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این قسمت را ندارید.');
    }
  }

  myproduceSale(int basketId)async {

    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/mybaskets/sales/${basketId}',
          headers: {
            HttpHeaders.authorizationHeader:'Bearer $token',
          },
        );
        print(response.body['basketproducts']);

        if (response.body['basketproducts']!=null) {

          for (var item in response.body['basketproducts']) {
            mybasketProductList.add(BasketProduct.fromJson(item));
          }

        } else {
          return;
        }
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

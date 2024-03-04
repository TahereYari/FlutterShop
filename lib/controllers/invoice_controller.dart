import 'dart:io';

import 'package:get/get.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/address.dart';
import 'package:myshop/models/basket.dart';
import 'package:myshop/models/basketproduct.dart';
import 'package:myshop/models/invoice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constans/constans.dart';

class InvoiceController extends GetConnect {
  RxList<Basket> invoiceSend = <Basket>[].obs;
  RxList<Basket> invoiceNotSend = <Basket>[].obs;
  Rx<Basket> basket = Basket().obs;
  Rx<Product> basketProduct = Product().obs;
  Rx<Address> address = Address().obs;
  RxList<BasketProduct> basketProductlist = <BasketProduct>[].obs;
  RxList<Product> productList = <Product>[].obs;

  late SharedPreferences pref;
  String token = '-1';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getProductList();
    getInvoiceList();

  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
  }

  getInvoiceList() async {

    await getToken();
    try {
      Response response = await get(
        '${locallhost}/admin/InvoiceList',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode! < 300) {
        for (var item in response.body['basketsNotSend']) {
          invoiceNotSend.add(
            Basket.fromJson(item),
          );
        }
        for (var item in response.body['basketssends']) {
          invoiceSend.add(
            Basket.fromJson(item),
          );
        }
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar('مشکلی پیش آمده است  دوباره تلاش کنید');
      print(s);
      print(e);
    }
  }

  invoiceProduct(int basketId) async {
    await getToken();
    try {
      Response response = await get(
        '${locallhost}/admin/Invoice/product/${basketId}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode! < 300) {
        basket.value = Basket.fromJson(response.body['basket']);
        address.value = Address.fromJson(response.body['address']);
        for (var item in response.body['basketproducts']) {
          basketProductlist.add(
            BasketProduct.fromJson(item),
          );
        }
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar('مشکلی پیش آمده است  دوباره تلاش کنید');
      print(s);
      print(e);
    }
  }
  getbasketProduct(int productId) async {
    await getToken();
    try {
      Response response = await get(
        '${locallhost}/basketproducts/${productId}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode! < 300) {

        basketProduct.value = Product.fromJson(response.body['product']);
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar('مشکلی پیش آمده است  دوباره تلاش کنید');
      print(s);
      print(e);
    }
  }

  invoiceSendBaskt(int basketId) async {
    await getToken();
    try {
      Response response = await get(
        '${locallhost}/admin/Invoice/send/${basketId}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode! < 300) {
        StaticMethodes.SuccesSnackBar(response.body['message']);
        invoiceSend.clear();
        invoiceNotSend.clear();
        getInvoiceList();
      } else {
        StaticMethodes.errorSnackBar(
            'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar('مشکلی پیش آمده است  دوباره تلاش کنید');
      print(s);
      print(e);
    }
  }

  getProductList() async {
    productList.clear();
    await getToken();
    try {
      Response response = await get(
        '${locallhost}/admin/product/list',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      print( response.body['products']);
      if (response.statusCode! < 300 &&
          response.body['products'] != null) {
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
      StaticMethodes.unSuccesSnackBar('مشکلی پیش آمده است  دوباره تلاش کنید');
      print(s);
      print(e);
    }
  }
}

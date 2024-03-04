import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/controllers/add_discount_basket_controller.dart';
import 'package:myshop/controllers/address_controller.dart';
import 'package:myshop/controllers/admin_controller.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/controllers/category_controller.dart';
import 'package:myshop/controllers/comment_cotroller.dart';
import 'package:myshop/controllers/discount_controller.dart';
import 'package:myshop/controllers/favorite_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/controllers/invoice_controller.dart';
import 'package:myshop/controllers/offcode_controller.dart';
import 'package:myshop/controllers/product_controller.dart';
import 'package:myshop/controllers/search_controller.dart';
import 'package:myshop/controllers/splash_controller.dart';
import 'package:myshop/controllers/user_admin_controller.dart';
import 'package:myshop/controllers/user_controller.dart';

class AppBinding implements Bindings{
  @override
  void dependencies() {

    //Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<SplashController>(()=>SplashController());
    Get.lazyPut<CategoryController>(()=>CategoryController(),fenix: true);
    Get.lazyPut<UserController>(() => UserController(),tag: 'login',fenix: true);
    Get.lazyPut<UserController>(() => UserController(),fenix: true);
    Get.lazyPut<UserController>(() => UserController(),tag: 'signup',fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(),fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
    Get.lazyPut<CommentController>(() => CommentController(),fenix: true);
    Get.lazyPut<AdminController>(() => AdminController(),fenix: true);
    Get.lazyPut<UserAdminController>(() => UserAdminController(),fenix: true);
    Get.lazyPut<DiscountController>(() => DiscountController(),fenix: true);
    Get.lazyPut<OffCodeController>(() => OffCodeController(),fenix: true);
    Get.lazyPut<BasketController>(() => BasketController(),fenix: true);
    Get.lazyPut<addDiscountBasketController>(() => addDiscountBasketController(),fenix: true);
    Get.lazyPut<AddressController>(() => AddressController(),fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(),fenix: true);
    Get.lazyPut<SearchScreenController>(() => SearchScreenController(),fenix: true);
    Get.lazyPut<InvoiceController>(() => InvoiceController(),fenix: true);
  }

}
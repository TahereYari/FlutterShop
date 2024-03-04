import 'dart:io';

import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetConnect{
  late SharedPreferences pref;
  String token = '-1';


  RxList<Favorite> favoriteList =<Favorite>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getFavorite();
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';
  }

  addFavorite(int productId) async {
    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/favorite/insert/${productId}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.statusCode! < 300) {

          StaticMethodes.SuccesSnackBar('محصول به لیست علاقه مندی شما اضافه شد.');
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

  getFavorite() async {
    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/favoriteView',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        print(response.body['favorites']);

        if (response.statusCode! < 300) {

        for(var item in response.body['favorites']){
          favoriteList.add(Favorite.fromJson(item));
        }


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

  deleteFavorite(int productId) async {
    await getToken();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/favorite/insert/${productId}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.statusCode! < 300) {
          StaticMethodes.SuccesSnackBar(response.body['message']);
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



}
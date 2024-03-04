import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentController extends GetxController{
  TextEditingController titleController  =TextEditingController();
  TextEditingController positiveController  =TextEditingController();
  TextEditingController negativeController  =TextEditingController();
  TextEditingController scoreController  =TextEditingController();
  TextEditingController commentController  =TextEditingController();

  RxList<Comment> commentList = <Comment>[].obs;
  RxList<Product> productList = <Product>[].obs;

  late SharedPreferences pref;
  String token = '-1';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getCommentList();
    getProductList();
  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }

  addComment(int id)async {
    await getToken();

    if (token == '-1') {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این عملیات را ندارید.');
      return;
    } else {
      String title = titleController.text;
      String posetive = positiveController.text;
      String negative = negativeController.text;
      String emteaz = scoreController.text;
      String comment = commentController.text;


      Map<String, dynamic> newMap = {};
      newMap['title'] = title;
      newMap['posetive'] = posetive;
      newMap['negative'] = negative;
      newMap['emteaz'] = emteaz;
      newMap['comment'] = comment;


        try {
          dio.Dio myDio = dio.Dio();
          // dio.FormData formData = dio.FormData.fromMap(newMap);
          dio.Response response = await myDio.post(
            '${locallhost}/product/comment/insert/$id',
            data: newMap,
            options: dio.Options(
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
              method: 'POST',
              contentType: 'application/json',
              responseType: dio.ResponseType.json,
            ),
          );
          if (response.statusCode!<300) {
            StaticMethodes.SuccesSnackBar('اطلاعات شما با موفقیت ذخیره شد.');
            reset();
              //  Get.toNamed(AppRouts.AddProductPicture ,arguments: id);
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


  void reset() {
    titleController.clear();
    positiveController.clear();
    negativeController.clear();
    scoreController.clear();
    commentController.clear();


  }

  getProductList() async {
    productList.clear();
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
      if (response.statusCode! < 300 && response.data['products'] != null) {
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

  getCommentList()async {
    await getToken();
    try {

      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/commentlist',
        options: dio.Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! < 300) {
        for (var item in response.data['comments']) {
          commentList.add(
            Comment.fromJson(item),
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

  commentActivity(int commentId)async {
    await getToken();
    try {

      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/commentactivity/${commentId}',
        options: dio.Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! < 300 ) {
      //  StaticMethodes.SuccesSnackBar(response.data['message']);
        commentList.clear();
        getCommentList();
        }
      else {
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

  deleteComment(int commentId)async {
    await getToken();
    try {

      dio.Dio myDio = dio.Dio();
      dio.Response response = await myDio.get(
        '${locallhost}/admin/commentdelete/${commentId}',
        options: dio.Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
      );

      if (response.statusCode! < 300 ) {
          StaticMethodes.SuccesSnackBar(response.data['message']);
        commentList.clear();
        getCommentList();
      }
      else {
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
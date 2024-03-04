
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/category.dart';

class SearchScreenController extends GetConnect{

  TextEditingController searchController = TextEditingController();
  RxList<Product> productList = <Product>[].obs;
  Rx<Category> category = Category().obs;
  Random random = Random();
  List<Color> color = [
    kLightGreyColor,
    kRedColor,
    kLightRedColor,
    kBlueColor,
    kGreyColor,
    kGreenColor,

    kLightYellowColor,
    kLightOrangeColor,

    kLightGreenColor,
    kPhirozeColor,
  ];


  search()async{
    FocusManager.instance.primaryFocus?.unfocus();
    productList.clear();
    String text = searchController.text;
    Response response = await get('${locallhost}/search/${text}');
    // print('response.bodyproducts');
    // print(response.body['products']);
    print('response.body');
    print(response.body);

    if(response.body!=null){
      //category.value = response.body['categoriename'];

      for(var item in response.body['products'])
        {
          productList.add(Product.fromJson(item));
        }

    }
    else {
      StaticMethodes.errorSnackBar(
          'خطا', 'هیچ پاسخی برای شما از سمت سرور دریافت نشد.');
    }
  }


}
import 'dart:io';
import 'dart:math';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/models/basket.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/models/comment.dart';
import 'package:myshop/models/discount.dart';
import 'package:myshop/models/favorite.dart';
import 'package:myshop/models/store.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/basket_screen.dart';
import 'package:myshop/widgets/front_search.dart';
import 'package:myshop/widgets/home_page_front.dart';
import 'package:myshop/widgets/profile_screen.dart';
import 'package:myshop/widgets/slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetConnect {
  RxList<Widget> imageSlider = <Widget>[].obs;
  RxList<Product> productImageList = <Product>[].obs;
  RxList<Product> mostViews = <Product>[].obs;
  RxList<Product> newProducts = <Product>[].obs;
  RxList<Category> categoryImages = <Category>[].obs;
  RxList<Comment> commentOfPtoduct = <Comment>[].obs;
  RxList<User> userList = <User>[].obs;
  RxList<Discount> discountList = <Discount>[].obs;

  Rx<Product> productOne = Product().obs;

  RxList<Product> pictureOfProducts = <Product>[].obs;
  Rx<Product> discountProduct = Product().obs;
  Rx<Discount> discountProduct2 = Discount().obs;
  RxList<Product> categoryProducts = <Product>[].obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<Basket> basketList = <Basket>[].obs;
  Rx<Store> store = Store().obs;

  RxList<Favorite> favoriteList = <Favorite>[].obs;

  RxInt currentIndex = 0.obs;
  RxInt currentSlide = 0.obs;
  RxInt offPrice = 0.obs;

  final Rx<CarouselController> carouselController = CarouselController().obs;
  final Rx<PageController> smoothController = PageController().obs;

  late SharedPreferences pref;
  String token = '-1';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSliderProduct();
    getFrontApi();
    getToken();
    print(token);
    getuserList();
   // getDiscountList();
    getFavorite();
    //productList.clear();
    getProductList();
    getStore();


  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }

  void onChangeSlide(int index, CarouselPageChangedReason reason) {
    currentSlide.value = index;
  }

  changeIndex(index) {
    currentIndex.value = index;
    if (index == 1) {
      Get.find<BasketController>().basketProductList.clear();
      Get.find<BasketController>().showPageCart();
      //Get.toNamed(AppRouts.basketScreen);
    }
    if (index == 0) {
      productImageList.clear();
      categoryImages.clear();
      mostViews.clear();
      newProducts.clear();
      getSliderProduct();
      getFrontApi();
    }
  }
  getStore() async {

    print('store');
    await getToken();
    print(token);
    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/admin/store',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        print(response.statusCode);
        if (response.statusCode! < 300) {
          store.value = Store.fromJson(response.body['store']);
          print(response.body['store']);
        } else {
          StaticMethodes.unSuccesSnackBar(
              'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
        }
      } catch (e, s) {
        StaticMethodes.unSuccesSnackBar(
            'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
      }
    }

  }

  List<Widget> homeWidget = [
    const HomePageFront(),
    const BasketScreen(),
    const FrontSearchScreen(),
  ];

  onDotClick(int index) {
    currentSlide.value = index;
    carouselController.value.animateToPage(index);
  }

  getSliderProduct() async {
    try {
      Response response = await get(
        '${locallhost}/front',
      );

      if (response.statusCode! < 300) {
        for (var item in response.body['productSlider']) {
          productImageList.add(Product.fromJson(item));
        }
        imageSlider.value = productImageList
            .map((item) => SliderWidget(product: item))
            .toList();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  getFrontApi() async {
    try {
      Response response = await get('${locallhost}/front');

      if (response.statusCode! < 300) {
        for (var item in response.body['MostViews']) {
          mostViews.add(Product.fromJson(item));
        }

        for (var item in response.body['NewProducts']) {
          newProducts.add(Product.fromJson(item));
        }

        for (var item in response.body['categorimages']) {
          categoryImages.add(Category.fromJson(item));
        }
      }
    } catch (e, s) {}
  }

  Future<void> previewProduct(int id) async {
    try {
      Response response = await get(
        '${locallhost}/previewproduct/$id',
      );

      if (response.statusCode! < 300) {
        productOne.value = Product.fromJson(response.body['Product_one']);

        for (var item in response.body['pictureOfProducts']) {
          pictureOfProducts.add(Product.fromJson(item));
        }

        for (var item in response.body['comments']) {
          commentOfPtoduct.add(Comment.fromJson(item));
        }

        Get.toNamed(AppRouts.previewProduct);
      }
    } catch (e, s) {
      print(e);
      print(s);
      StaticMethodes.unSuccesSnackBar(
          'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
    }
  }

  getuserList() async {
    userList.clear();
    await getToken();
    try {
      Response response = await get('${locallhost}/userSite/list');

      if (response.body['users'] != null) {
        for (var item in response.body['users']) {
          userList.add(User.fromJson(item));
        }
      } else {
        // StaticMethodes.errorSnackBar(
        //     'خطا', 'شما دسترسیی به این عملیات را ندارید.');
        return;
      }
    } catch (e, s) {
      print(e);
      print(s);
      StaticMethodes.unSuccesSnackBar(
          'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
    }
  }

  // getDiscountList() async {
  //   await getToken();
  //   try {
  //     Response response = await get('${locallhost}/admin/offs/list');
  //
  //     if (response.body['discountProducts'] !=null) {
  //       for (var item in response.body['discountProducts']) {
  //         discountList.add(Discount.fromJson(item));
  //       }
  //     } else {
  //       // StaticMethodes.errorSnackBar(
  //       //     'خطا', 'شما دسترسیی به این عملیات را ندارید.');
  //       return;
  //     }
  //   } catch (e, s) {
  //     print(e);
  //     print(s);
  //     StaticMethodes.unSuccesSnackBar(
  //         'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
  //   }
  // }

  getDiscountProductList(int ProductId) async {
    try {
     // offPrice.value = 0;
      Response response =
          await get('${locallhost}/discountOfProduct/${ProductId}');
      if (response.statusCode! < 300) {
        // discountProduct.value =Product.fromJson(response.body['product']);
        // discountProduct2.value =Discount.fromJson(response.body['discount']);
        // offPrice.value = 0;
        offPrice.value = response.body['offprice2'];
      } else {
        // StaticMethodes.errorSnackBar(
        //     'خطا', 'شما دسترسیی به این عملیات را ندارید.');
        return;
      }
    } catch (e, s) {
      print(e);
      print(s);
      StaticMethodes.unSuccesSnackBar(
          'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
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


      if (response.statusCode! < 300 ) {
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
      StaticMethodes.unSuccesSnackBar(
          'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
    }
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
          StaticMethodes.SuccesSnackBar(response.body['message']);
        } else {
          StaticMethodes.unSuccesSnackBar(
              'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
        }
      } catch (e, s) {
        print(e);

      }
    } else {
      StaticMethodes.errorSnackBar(
          'خطا', 'شما اجازه دسترسی به این قسمت را ندارید.');
    }
  }

  getFavorite() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await getToken();
    favoriteList.clear();

    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/favoriteView',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.body['favorites'] != null) {
          for (var item in response.body['favorites']) {
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

  getMyBasket() async {
    await getToken();
    int? userId = pref.getInt('user_id');


    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/mybaskets/${userId}',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );
        print('mybaskets');
        print(response.body['mybaskets']);

        if (response.body['mybaskets'] != null) {
          for (var item in response.body['mybaskets']) {
            basketList.add(Basket.fromJson(item));
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

  getCategoryProduct(int id) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      Response response = await get(
        '${locallhost}/front/categoryProduct/${id}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.body['products'] != null) {
        for (var item in response.body['products']) {
          categoryProducts.add(Product.fromJson(item));
        }
      } else {
        StaticMethodes.unSuccesSnackBar(
            'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
      }
    } catch (e, s) {
      StaticMethodes.unSuccesSnackBar(
          'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
    }
  }
}

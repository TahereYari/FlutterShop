import 'dart:io';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/models/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminController extends GetConnect {

  RxInt userCount = 0.obs;
  RxInt userUser = 0.obs;
  RxInt userNotUser = 0.obs;
  RxInt products = 0.obs;

  Rx<Store> store = Store().obs;

  Rx<User> activeUser = User().obs;


  late SharedPreferences pref;
  String token = '-1';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStore();
    getToken();
    getAdmin();
    getActiveUser();

  }

  getAdmin() async {
    await getToken();

    if (token != '-1') {
      Response response = await get(
        '${locallhost}/admin',
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      //
      if(response.statusCode! < 300){
        userCount.value = response.body['userCount'];
        userUser.value = response.body['useruser'];
        userNotUser.value = response.body['usernotuser'];
        products.value = response.body['products'];

      }

    }
  }

  getActiveUser() async {
    await getToken();
    int? userId = pref.getInt('user_id');
try{
  if (token != '-1') {
    Response response = await get(
      '${locallhost}/activeUser/${userId}',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );


    if(response.statusCode! < 300){
      activeUser.value = User.fromJson(response.body['user']);
    }



  }
}
catch(e){
  StaticMethodes.unSuccesSnackBar(
      'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
}

  }

  Future<void> getToken() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token') ?? '-1';

    // role = pref.getString('role') ?? 'user';
  }

  getStore() async {
    await getToken();
    if (token != '-1') {
      try {
        Response response = await get(
          '${locallhost}/admin/store',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        );

        if (response.statusCode! < 300) {
          store.value = Store.fromJson(response.body['store']);
          print(response.body['store']);
        } else {
          StaticMethodes.unSuccesSnackBar(
              'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
        }
      }

      catch (e, s) {
        StaticMethodes.unSuccesSnackBar(
            'مشکلی به وجود آمده لطفا دوباره تلاش کنید.');
      }
    }

  }
}

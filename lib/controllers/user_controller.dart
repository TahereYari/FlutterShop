import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  late SharedPreferences pref;
  RxBool showPassword = false.obs;

  @override
  onInit() {
    super.onInit();
  }

  loadPref() async {
    pref = await SharedPreferences.getInstance();
  }
  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  SingnUp() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passController.text;
    String confirm = confirmPassController.text;

    if (StaticMethodes.validateName(name, ' نام کاربری') &&
        StaticMethodes.validatePassword(password) &&
        StaticMethodes.validateEmail(email) &&
        StaticMethodes.validateEmail(confirm)) {
      try {
        http.Response response =
            await http.post(Uri.parse('${locallhost}/register'),
                body: convert.jsonEncode({
                  'name': name,
                  'email': email,
                  'password': password,
                  // 'password-confirmation': password,
                }),
                headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            });
        pref = await SharedPreferences.getInstance();
        Map responseMap = convert.jsonDecode(response.body);
        if (response.statusCode < 300) {
          User user = User.fromJson(responseMap['user']);
          pref.setString('token', responseMap['token']);
          pref.setString('name', user.name!);
          pref.setString('email', user.email!);
          pref.setString('password', user.password!);
          pref.setInt('user_id', user.id!);
          pref.setInt('role_id', user.roleId!);

          Get.offNamed(AppRouts.homeScreen);
        }
        else {
          List list = responseMap['errors']['email'];
          StaticMethodes.errorSnackBar('خطا', list.first);
        }
      } catch (e, s) {
        print(s);
      }
    }
  }

  LogIn() async {
    String email = emailController.text;
    String password = passController.text;

    if (StaticMethodes.validatePassword(password) &&
        StaticMethodes.validateEmail(email)) {
      try {
        http.Response response = await http.post(
          Uri.parse('${locallhost}/login'),
            body: convert.jsonEncode({
              'email': email,
              'password': password,
            }),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            });
        Map responseMap = convert.jsonDecode(response.body.toString());
        pref = await SharedPreferences.getInstance();
        if(response.statusCode < 300){
          User user =User.fromJson(responseMap['user']);
          await pref.setString('token', responseMap['token']);
          await pref.setString('email', user.email!);
          await pref.setString('name', user.name!);
          await pref.setInt('user_id', user.id!);
          await pref.setString('password', password!);
          await pref.setInt('role_id', user.roleId!);

          Get.offNamed(AppRouts.firstAdminScreen);
          print('password');
          print(pref.getString('password'));
        }
        else{
          // StaticMethodes.errorSnackBar('خطا',  responseMap['status']);
          StaticMethodes.errorSnackBar('خطا',  'هیچ کاربری با این اطلاعات وارد شده وجود ندارد.');
        }

      } catch (e, s) {
        print(s);
      }
    }
  }

  logOut() async{
    pref = await SharedPreferences.getInstance();
   // await http.get(Uri.parse('${locallhost}/logout'),);
    pref.clear();
    Get.offAllNamed(AppRouts.logInScreen);

  }


}

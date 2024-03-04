import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/controllers/binding/app_binding.dart';
import 'package:myshop/screens/home_screen.dart';
import 'package:myshop/screens/splash_screen.dart';
import 'package:myshop/services/app_routs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IRANSansWebMedium',
      ),
      initialRoute: AppRouts.splashScreen,
      title: 'فروشگاه آنلاین',
      getPages: AppRouts.getPages,
      locale: const Locale('fa','IR'),
      fallbackLocale: Locale('en', 'UK'),
      initialBinding: AppBinding(),
      defaultTransition: Transition.leftToRightWithFade,


    );
  }
}



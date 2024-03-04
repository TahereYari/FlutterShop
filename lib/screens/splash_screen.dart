import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/splash_controller.dart';
import 'package:myshop/widgets/widget_loading.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  SplashController controller =Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset('assets/images/mainLogo.png'),
            const SizedBox(
              height: 50,
            ),
             Text('به فروشگاه آنلاین ما خوش آمدید',style: kHeaderText.copyWith(fontSize: 20),),
            // Image.asset('name'),
            const SizedBox(
              height: 50,
            ),

            const Spacer(),
            WidgetLoading(),
            const SizedBox(
              height: 30,
            ),
          ],


        ),
      ),
    );
  }
}

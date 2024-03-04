import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        children: [
          const Spacer(),
          Text('شما مدیر اپلیکیشن هستید برای ورود یکی از گزینه های زیر را انتخاب کنید.',style: kTextStyle.copyWith(fontWeight: FontWeight.bold,color: kRedColor),),
          const SizedBox(height: 20,),
          Material(
            child: InkWell(
            onTap: (){
              Get.offNamed(AppRouts.firstAdminScreen);
            },
              child: Container(
                height: 100,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: kBlueColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60.0),
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child:  Center(
                  child: Text(
                    'مدیریت',
                    style: kTextStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Material(
            child: InkWell(
              onTap: (){
                Get.offNamed(AppRouts.firstScreenFront);
              },
              child: Container(
                height: 100,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: kGreenColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(60.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(60.0),
                  ),
                ),
                child:  Center(
                  child: Text(
                    'برنامه',
                    style: kTextStyle.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.width,
    this.height,
    required this.text,
    required this.onTapped,
    this.fontSize, this.color, this.fontColor,
  });

  final double? width;
  final double? height;
  final double? fontSize;
  final String text;
  final VoidCallback onTapped;
  final Color? color;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      color: color ?? kLightOrangeColor ,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        highlightColor: color ?? kGreenColor,
        onTap:onTapped ,
        child: SizedBox(
          width:  width ?? Get.width,
          height: height ?? 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: kTextStyle.copyWith(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: fontColor ?? kBlackColor
              ),
            ),
          ),
        ),
      ),
    );
  }
}

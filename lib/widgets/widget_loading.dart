import 'package:flutter/material.dart';
import 'package:myshop/constans/constans.dart';

class WidgetLoading extends StatelessWidget {
  const WidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(15),
      child:  const CircularProgressIndicator(
        backgroundColor: kLightOrangeColor,
        strokeWidth: 6,
        valueColor: AlwaysStoppedAnimation(kRedColor),
      ),

    );
  }
}

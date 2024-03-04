import 'package:flutter/material.dart';
import 'package:myshop/constans/constans.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({
    super.key,
    required this.color,
    required this.text1,
    required this.text2,
  });

  final Color color;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(

          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(70.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text(
                text1.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 90,
          right: 50,
          child: Container(
            width: 190,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white.withOpacity(0.5),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black.withOpacity(0.25),
              //       blurRadius: 20),
              // ],
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  right: 50,
                  child: Text(
                    text2.toString(),
                    style: kHeaderText.copyWith(color: kBlackColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

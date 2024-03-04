import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myshop/constans/constans.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({
    super.key,
    this.background,
    this.appBar,
    this.padding=20.0,
    required this.child, this.floatingActionButton,
  });

  final Color? background;
  final Widget child;
  final AppBar? appBar;
  final double? padding;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background ?? Colors.white,
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding!),
        child:child,
      ),
    );
  }
}

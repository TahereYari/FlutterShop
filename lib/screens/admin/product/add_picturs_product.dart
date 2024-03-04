import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/controllers/product_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/widgets/base_widget.dart';

class AddPictureProduct extends GetView<ProductController> {
   AddPictureProduct({super.key});
//int id =Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        children: [
     //   Text(id.toString()),
        ],
      ),
    );
  }
}

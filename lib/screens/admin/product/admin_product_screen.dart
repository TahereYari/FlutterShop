import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/widgets/base_widget.dart';

class AdminProductScreen extends StatelessWidget {
   AdminProductScreen({super.key});
  Product product =Get.arguments;
  String? categoryName = Get.parameters['categoryName'];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          product.name!,
          style: kHeaderText,
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Image.network(
                'http://10.0.2.2:8000/image/${product.image}',
                height: 200,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Text('نام:' ,style: kHeaderText.copyWith(fontSize: 23),),
                        SizedBox(width: 30,),
                        Text(product.name!, style: kTextStyle,),
                            
                      ],
                    ),
                  ),
                  const Divider(thickness: 2,),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Text('ویژگی ها:' ,style: kHeaderText.copyWith(fontSize: 23),),
                        SizedBox(width: 30,),
                        Expanded(
                            child: Text(product.propertise!, style: kTextStyle,)),

                      ],
                    ),
                  ),
                  const Divider(thickness: 2,),

                  SizedBox(height: 30,),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Text(' قیمت:' ,style: kHeaderText.copyWith(fontSize: 23),),
                        SizedBox(width: 30,),
                        Text(
                         ' ${product.price!.toString()} ریال ', style: kTextStyle,),

                      ],
                    ),
                  ),
                  const Divider(thickness: 2,),

                  SizedBox(height: 30,),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Text(' تعداد:' ,style: kHeaderText.copyWith(fontSize: 23),),
                        SizedBox(width: 30,),
                        Text(product.number!.toString(), style: kTextStyle,),

                      ],
                    ),
                  ),
                  const Divider(thickness: 2,),

                  SizedBox(height: 30,),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Text(' نوع دسته:' ,style: kHeaderText.copyWith(fontSize: 23),),
                        SizedBox(width: 30,),
                        Text(categoryName!, style: kTextStyle,),

                      ],
                    ),
                  ),
                  const Divider(thickness: 2,),
                ],

              ),


            ],

          ),
        ),
      ),
    );
  }
}

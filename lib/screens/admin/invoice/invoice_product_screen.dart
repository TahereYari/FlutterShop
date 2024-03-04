import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/invoice_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/basketproduct.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:collection/collection.dart';

class InvoiceProductScreen extends GetView<InvoiceController> {
  InvoiceProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'لیست فاکتورها',
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
      child: Column(
        children: [
          Expanded(

            child: Obx(() {
              return ListView.separated(
                itemCount: controller.basketProductlist.length,
                itemBuilder: (context, index) {
                  BasketProduct basketProduct =
                      controller.basketProductlist[index];


                  String? productName = controller.productList
                      .where((product) =>product.id == basketProduct.productId  )
                      .first
                      .name;
                  print(productName);

                  String? productImage = controller.productList
                      .where((product) => basketProduct.productId == product.id)
                      .first
                      .image;

                  int? productPrice = controller.productList
                      .where((product) => product.id == basketProduct.productId)
                      .first
                      .price;



                  return ListTile(
                     title: Text(productName!),
                    leading: Image.network(
                      'http://10.0.2.2:8000/image/${productImage}',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'تعداد: ',
                              style: kTextStyle,
                            )),
                            Expanded(
                                child: Text(basketProduct.count!.toString())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'قیمت هر عدد: ',
                              style: kTextStyle,
                            )),
                            // Expanded(
                            //     child:
                            //         Text('${productPrice!.toString()} ریال')),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'قیمت در تخفیف: ',
                              style: kTextStyle,
                            )),
                            Expanded(
                              child: Text(basketProduct.offprice!.toString()),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              'قیمت نهایی: ',
                              style: kTextStyle,
                            )),
                            Expanded(
                                child:
                                    Text(basketProduct.pricefull.toString())),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: kGreenColor,
                ),
              );
            }),
          ),
          Divider(
            color: kRedColor,
            thickness: 3,
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'قیمت کل : ',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        child: Text(
                            ([ controller.basket.value.price, controller.basket.value.offcode].fold(0, (p, c) => p + c!)).toString()),),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'میزان تخفیف نهایی : ',
                        style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                          child:
                              Text(controller.basket.value.offcode.toString())),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            'قیمت قابل پرداخت : ',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          child:
                          Text(controller.basket.value.price.toString())),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            'آدرس : ',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          child:
                          Text(controller.address.value.address!)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

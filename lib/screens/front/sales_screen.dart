import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/basket.dart';
import 'package:myshop/models/basketproduct.dart';
import 'package:myshop/widgets/base_widget.dart';

class SaleScreen extends GetView<BasketController> {
   SaleScreen({super.key});
   // int? offCode = Get.parameters['offCode'] as int?;
Basket basket = Get.arguments;
// int? lastOff = ((basket.price)+(basket.offcode!));

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          'لیست محصولات ',
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
          SizedBox(
            height: 400,
            child: Obx(
              () => ListView.separated(
                itemCount: controller.mybasketProductList.length,
                itemBuilder: (context, index) {
                  BasketProduct basketProduct = controller.mybasketProductList[index];
                  String? productName = controller.productList
                      .where((product) =>
                  product.id == basketProduct.productId)
                      .first
                      .name;
                  int? productPrice = controller.productList
                      .where((product) =>
                  product.id == basketProduct.productId)
                      .first
                      .price;
                  String? productImage = controller.productList
                      .where((product) =>
                  product.id == basketProduct.productId)
                      .first
                      .image;
                  print('productImage');
                  print(productImage);
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
                                child: Text(
                                    basketProduct.count!.toString())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  'قیمت هر عدد: ',
                                  style: kTextStyle,
                                )),
                            Expanded(
                                child: Text(
                                    '${productPrice!.toString()} ریال')),
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
                              child: Text(
                                  basketProduct.offprice!.toString()),
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
                                child: Text(basketProduct.pricefull
                                    .toString())),
                          ],
                        ),

                      ],
                    ),

                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(color: kGreenColor),
              ),
            ),
          ),
          const Divider(
            color: kRedColor,
            thickness: 3,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child:Column(
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
                            ([ basket.price, basket.offcode].fold(0, (p, c) => p + c!)).toString()),),
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
                          Text(basket.offcode.toString())),
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
                          Text(basket.price.toString())),
                    ],
                  ),
                  const SizedBox(height: 10,),

                ],
              ),

          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/add_discount_basket_controller.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/basketproduct.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';
import 'package:myshop/widgets/widget_loading.dart';

class BasketScreen extends GetView<BasketController> {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      // appBar: AppBar(
      //   backgroundColor: kLightBlueColor,
      //   title: Text(
      //     'سبد خرید',
      //     style: kHeaderText,
      //   ),
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: Get.back,
      //     icon: const Icon(
      //       Icons.arrow_back_rounded,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Obx(
            () => controller.basketProductList.isEmpty &&
                    controller.basket.value != null
                ? const Center(
                    child: WidgetLoading(),
                  )
                : Expanded(
                    child: ListView.separated(
                      //  controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.basketProductList.length,
                      itemBuilder: (context, index) {
                        BasketProduct basketProduct =
                            controller.basketProductList[index];
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
                        return SingleChildScrollView(
                          child: ListTile(
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
                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kGreenColor,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          controller.stepUp(
                                              controller.basket.value.id!,
                                              basketProduct.id!);
                                        },
                                        icon: const Icon(Icons.add_rounded,
                                            color: Colors.white, size: 30),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 30,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                            child: Text(basketProduct.count
                                                .toString())),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kRedColor,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          controller.stepDown(
                                              controller.basket.value.id!,
                                              basketProduct.id!);
                                        },
                                        icon: const Icon(Icons.minimize_sharp,
                                            color: Colors.white, size: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.deleteItemBasket(
                                    controller.basket.value.id!,
                                    basketProduct.id!);
                              },
                              icon: const Icon(Icons.delete,
                                  color: kRedColor, size: 30),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ),
          ),
          Obx(() => controller.basketProductList.isEmpty &&
                  controller.basket.value != null
              ? const Center(
                  child: Text(''),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        children: [
                          MyTextFeild(
                            width: Get.width-100,
                            controller: Get.find<addDiscountBasketController>()
                                .codeController,
                            hintText: 'کد تخفیف',
                          ),
                          IconButton(
                            onPressed: () {
                              Get.find<addDiscountBasketController>()
                                  .addDiscount(controller.basket.value.id!);
                            },
                            icon: Icon(
                              Icons.check_circle_outline,
                              size: 40,
                              color: kGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'قیمت قابل پرداخت: ',
                          style: kTextStyle,
                        ),
                        Get.find<addDiscountBasketController>()
                                    .newPrice
                                    .value !=
                                0
                            ? Text(Get.find<addDiscountBasketController>()
                                .newPrice
                                .toString())
                            : Text(controller.basket.value.price.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        text: 'تکمیل فرآیند خرید',
                        onTapped: () {
                          Get.toNamed(AppRouts.addressScreen);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}

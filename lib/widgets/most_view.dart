import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/widgets/widget_loading.dart';

class MostViews extends GetView<HomeController> {
   MostViews({super.key});
  final oCcy = NumberFormat.currency(
      locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: 'ریال',
      decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'پربازدیدترین محصولات',
                style: kHeaderText.copyWith(fontSize: 20),
              ),
              // InkWell(
              //   onTap: () {},
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   child: Text(
              //     'مشاهده همه',
              //     style: kHeaderText.copyWith(
              //       fontSize: 20,
              //       color: kGreenColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: Obx(() =>
          controller.mostViews.isEmpty
              ? const Center(child: WidgetLoading(),)
              :
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.mostViews.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = controller.mostViews[index];
                //  controller.getDiscountList();
                  // Discount? discount = controller.discountList.firstWhere(
                  //         (disc) => disc.productId == product.id,
                  //     orElse: () => null!);
                 // print(discount.off);
                  return Container(
                    color: kPhirozeColor,
                    width: 200,
                    margin: EdgeInsets.only(
                      right:
                          controller.mostViews.first.id == product.id ? 0 : 5,
                      left: controller.mostViews.last.id == product.id ? 0 : 5,
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () {
                        controller.previewProduct(product.id!);
                      },
                      child: Container(
                        width: 160,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: Image.network(
                                'http://10.0.2.2:8000/image/${product.image}',
                                height: 120,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              product.name!,
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              width: Get.width-60,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: kGreenColor,
                                borderRadius:
                                BorderRadiusDirectional.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  oCcy.format(product.price).toString()!,
                                  style: kTextStyle.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  controller.token != '-1'
                                      ? Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kLightOrangeColor,
                                              ),
                                              padding: const EdgeInsets.all(1),
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.find<
                                                      BasketController>()
                                                      .addToBasket(
                                                      product
                                                          .id!);
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .add_shopping_cart_outlined,
                                                  color: kRedColor,
                                                ),
                                              ),
                                            ),
                                           const SizedBox(width: 5,),
                                            Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: kLightOrangeColor,
                                              ),
                                              padding: const EdgeInsets.all(1),
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.addFavorite(
                                                      product.id!);
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: kRedColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '',
                                          style: kTextStyle,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}

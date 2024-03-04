import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/models/discount.dart';
import 'package:myshop/models/favorite.dart';
import 'package:myshop/widgets/base_widget.dart';

class FavoriteScreen extends GetView<HomeController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.favoriteList.clear();
        controller.productList.clear();
        return true;
      },
      child: BaseWidget(
        appBar: AppBar(
          backgroundColor: kBlueColor,
          title: Text(
            'لیست علاقه مندی ها',
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
        child: Obx(
          () => Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              if (controller.favoriteList.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      'لیست علاقه مندی شما خالی است.',
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    children: List.generate(
                      controller.favoriteList.length,
                      (index) {
                        Favorite fave = controller.favoriteList[index];
                        Product? product = controller.productList
                            .where((p) => p.id == fave.productId )
                            .first;
                        print('name');
                        print(product.name);

                        String? productName = controller.productList
                            .where((product) => product.id == fave.productId)
                            .first
                            .name;
                        int? productPrice = controller.productList
                            .where((product) => product.id == fave.productId)
                            .first
                            .price;
                        int? productId = controller.productList
                            .where((product) => product.id == fave.productId)
                            .first
                            .id;

                        int? number = controller.productList
                            .where((product) => product.id == fave.productId)
                            .first
                            .number;

                        String? productImage = controller.productList
                            .where((product) => product.id == fave.productId)
                            .first
                            .image;


                        return InkWell(
                          onTap: () {
                            controller.previewProduct(productId!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: kLightGreenColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.redAccent,
                              ),
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                              left: 10,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    'http://10.0.2.2:8000/image/${productImage!}',
                                    height: 80,
                                    width: Get.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    productName!,
                                    style: kHeaderText.copyWith(
                                      fontSize: 16,
                                      color: kBlackColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    productPrice.toString(),
                                    style: kHeaderText.copyWith(
                                      fontSize: 12,
                                      // color: controller
                                      //     .color[controller.random.nextInt(10)],
                                      color: kBlackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        controller.token != '-1'
                                            ? Row(
                                                children: [
                                                  number == 0
                                                      ? Text(
                                                          'ناموجود',
                                                          style: kHintText
                                                              .copyWith(
                                                                  color:
                                                                      kRedColor),
                                                        )
                                                      : Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: kBlueColor,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Get.find<
                                                                      BasketController>()
                                                                  .addToBasket(
                                                                      productId!);
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .add_shopping_cart_outlined,
                                                              color: kRedColor,
                                                            ),
                                                          ),
                                                        ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kBlueColor,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(1),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          controller
                                                              .addFavorite(
                                                                  productId!);
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .favorite_border_outlined,
                                                            color: kRedColor)),
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
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

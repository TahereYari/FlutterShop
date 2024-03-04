import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/widgets/base_widget.dart';

class ProductCategory extends GetView<HomeController> {
   ProductCategory({super.key});
  String name = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.categoryProducts.clear();
        return true;
      },
      child: BaseWidget(
        appBar: AppBar(
          backgroundColor: kBlueColor,
          title: Text(
            ' محصولات دسته ${name}',
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
              SizedBox(
                height: 20,
              ),
              if (controller.categoryProducts.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Text(
                      'برای دسته بندی  ${name} محصولی وجود ندارد. ',
                      style: kTextStyle,
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
                      controller.categoryProducts.length,
                          (index) {
                        Product product = controller.categoryProducts[index];

                        return InkWell(
                          onTap: () {
                            controller.previewProduct(product!.id!);
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      'http://10.0.2.2:8000/image/${product?.image}',
                                      height: 80,
                                      width: Get.width,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      product!.name!,
                                      style: kHeaderText.copyWith(
                                        fontSize: 16,
                                        // color: controller
                                        //     .color[controller.random.nextInt(10)],
                                        color: kBlackColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(

                                      product!.price.toString(),
                                      style: kHeaderText.copyWith(
                                        fontSize: 12,
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
                                              product.number == 0
                                                  ? Text('ناموجود',style: kHintText.copyWith(color: kRedColor),)
                                                  :Container(
                                                decoration:
                                                const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: kBlueColor,
                                                ),
                                                padding:
                                                const EdgeInsets.all(1),
                                                child:
                                                IconButton(
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
                                                      controller.addFavorite(
                                                          product.id!);
                                                    },
                                                    icon: Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                        color: kRedColor)),
                                              ),
                                            ],
                                          )
                                              : Text(
                                            'امتیاز',
                                            style: kTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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

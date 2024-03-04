import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/basket.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';

class MyBasketScreen extends GetView<HomeController> {
  const MyBasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          'لیست خرید های من',
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
        () => ListView.separated(
          itemCount: controller.basketList.length,
          itemBuilder: (BuildContext context, int index) {
            Basket basket = controller.basketList[index];
            return ListTile(
              title: Row(
                children: [
                  Expanded(
                      child: Text('شماره فاکتور: ',
                          style: kTextStyle.copyWith(
                              fontWeight: FontWeight.bold))),
                  Expanded(
                    child: Text(basket.invoiceNumber!.toString()),
                  ),
                ],
              ),
              subtitle: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text('تاریخ خرید: ',
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold))),
                        Expanded(child: Text(basket.createdAt!)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text('تاریخ ارسال: ',
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold))),
                        Expanded(
                            child: basket.send == 0
                                ? Text(
                                    'ارسال نشده',
                                    style: kTextStyle,
                                  )
                                : basket.isPay == 0
                                    ? Text(('کنسل شده'))
                                    : Text((basket.updatedAt!))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          'مبلغ کل خرید : ',
                          style: kTextStyle,
                        )),
                        Expanded(child: Text(basket.price.toString())),
                      ],
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Get.find<BasketController>().mybasketProductList.clear();
                  Get.find<BasketController>().myproduceSale(basket.id!);
                  Get.toNamed(AppRouts.saleScreen, arguments: basket);
                },
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  color: kGreenColor,
                  size: 30,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: kGreenColor,
            thickness: 2,
          ),
        ),
      ),
    );
  }
}

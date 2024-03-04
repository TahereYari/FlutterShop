import 'package:flutter/material.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/discount_controller.dart';
import 'package:myshop/models/discount.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:persian/persian.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:intl/intl.dart';

class DiscountList extends GetView<DiscountController> {
  const DiscountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRouts.addDiscountScreen);
          },
          backgroundColor: kBlueColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        appBar: AppBar(
          backgroundColor: kLightBlueColor,
          title: Text(
            'لیست تخفیفات',
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
            itemCount: controller.discountList.length,
            itemBuilder: (BuildContext context, int index) {
              Discount discount = controller.discountList[index];
              String? ProductName = controller.productList
                  .where((product) => product.id == discount.productId)
                  .first
                  .name;


              // String startdate1 = DateFormat().format(discount.startdate as DateTime);
              // DateTime? enddate1 = discount.enddate as DateTime;

             // DateTime startdate = startdate1.toPersian();
             // print(startdate);
              // PersianDate enddate = enddate1.toPersian();


              return ListTile(
                title:  Row(
                  children: [
                    Expanded(child: Text('نام محصول: ',style: kTextStyle,)),
                    Expanded(child:  Text(ProductName!),),
                  ],

                ),
                subtitle: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('تاریخ شروع: ',style: kTextStyle,)),
                          Expanded(child: Text((discount.startdate!.toString()))),
                        ],

                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('تاریخ پایان: ',style: kTextStyle,)),
                          Expanded(child: Text((discount.enddate.toString()))),
                        ],

                      ),


                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('میزان تخفیف: ',style: kTextStyle,)),
                          Expanded(child: Text('${discount.off!.toString()} درصد')),

                        ],

                      ),


                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: kGreenColor,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // StaticMethodes.deleteSnackBar('محصول', product.name!,
                          //         () => controller.deleteProduct(product.id!));
                          //
                        },
                        icon: const Icon(Icons.delete,
                            color: kRedColor, size: 30),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: kGreenColor, thickness: 2,
            ),
          ),
        ),);
  }
}

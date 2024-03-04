import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/address_controller.dart';
import 'package:myshop/controllers/basket_controller.dart';
import 'package:myshop/models/address.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'آدرس کاربر ',
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
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.addressList.isEmpty
                    ?  Center(
                        child: Text('شما آدرس ذخیره شده ای ندارید',style: kTextStyle,),
                      )

                    : Expanded(
                        child: ListView.separated(
                            itemCount: controller.addressList.length,
                            itemBuilder: (context, index) {
                              Address address = controller.addressList[index];
                              return  ListTile(
                                title: Expanded(child: Text(address.address!),),
                                onTap: (){
                                  Get.find<BasketController>().checkOut(address.id!);

                                },

                              );
                            },
                            separatorBuilder: (context, index) =>  Divider(color: kGreenColor,),
                            ),
                      ),
              ),

              MyTextFeild(
                controller: controller.nameController,
                hintText: 'نام و نام خانوادگی',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                controller: controller.ostanController,
                hintText: 'استان',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                controller: controller.shahahrController,
                hintText: 'شهر',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                controller: controller.codeController,
                hintText: 'کد پستی',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                controller: controller.telController,
                hintText: 'شماره تلفن',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFeild(
                controller: controller.detailController,
                hintText: 'جزییات آدرس',
              ),
              const SizedBox(
                height: 10,
              ),
              MyButton(text: 'ثبت', onTapped: () {
               controller.addAddress();


              }),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

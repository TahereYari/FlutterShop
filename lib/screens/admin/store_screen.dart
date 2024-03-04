import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/admin_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';

class StoreScreen extends GetView<AdminController> {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        appBar: AppBar(
          backgroundColor: kLightBlueColor,
          title: Text(
            'اطلاعات فروشگاه ',
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
        child: Obx(() {
          return ListView(
            children: [
             const SizedBox(height: 10,),
              Row(
                children: [
                   Text('نام فروشگاه : ',style: kTextStyle.copyWith(fontWeight: FontWeight.bold),),
                Text(controller.store.value.name.toString(),style: kTextStyle,),
                ],
              ),
              const Divider(
                color: kGreenColor,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                   Text('شماره تلفن :',style: kTextStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text(controller.store.value.tel1.toString(),style: kTextStyle,)
                ],
              ),
              const Divider(
                color: kGreenColor,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                   Text('ایمیل :',style: kTextStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text(controller.store.value.email!.toString(),style: kTextStyle),
                ],
              ),
              const Divider(
                color: kGreenColor,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                   Text('آدرس اینستاگرام :',style: kTextStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text(controller.store.value.instagram!.toString(),style: kTextStyle),
                ],
              ),
              const Divider(
                color: kGreenColor,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                   Text('آدرس تلگرام :',style: kTextStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text(controller.store.value.telegram!.toString(),style: kTextStyle),
                ],
              ),
              const Divider(
                color: kGreenColor,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                   Text('آدرس فروشگاه :',style: kTextStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text(controller.store.value.address!.toString(),style: kTextStyle),
                ],
              ),
              const Divider(
                color: kGreenColor,
              ),
              const SizedBox(height: 10,),

              Image.network(
                'http://10.0.2.2:8000/image/${controller.store.value.image}',
                width: Get.width,
                height: 300,
                fit: BoxFit.cover,
              ),

              const Divider(
                color: kGreenColor,
              ),

              MyButton(text: 'ویرایش اطلاعات', onTapped: (){}),
              const SizedBox(height: 10,),
            ],
          );
        }));
  }
}

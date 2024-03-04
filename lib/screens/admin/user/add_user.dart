import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/user_admin_controller.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class AddUser extends GetView<UserAdminController> {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'افزودن کاربر',
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
      //padding: 0,
      child: SingleChildScrollView(
       // padding: EdgeInsets.symmetric(vertical: 5.0),
        child: SizedBox(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const SizedBox(
                height: 20,
              ),
              Text(
                'نام کاربر ',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.nameController),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   ' شماره تلفن ',
              //   style: kTextStyle,
              // ),
              // MyTextFeild(controller: controller.telController),
              const SizedBox(
                height: 20,
              ),
              Text(
                'ایمیل',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.emailController),
              const SizedBox(
                height: 20,
              ),
              Text(
                'نوع دسترسی',
                style: kTextStyle,
              ),
              Obx(() => SizedBox(
                width: Get.width-40,
                child: DropdownButton(
                    value: controller.dropDownValue.value,
                    isExpanded: true,
                    style: kTextStyle,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 0,
                    underline: Container(
                      height: 2,
                      color: kGreenColor,
                    ),
                    items: controller.dropDownRoleList.value,
                    onChanged: (int? value) {
                      controller.dropDownValue.value = value!;
                    }),
              )),
              Text(
                'رمز عبور',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.passController ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'تکرار رمز عبور',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.confirmPassController),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 40,
              ),
              MyButton(text: 'ثبت', onTapped: () {
                controller.addUser();
              }),
            
            //  const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

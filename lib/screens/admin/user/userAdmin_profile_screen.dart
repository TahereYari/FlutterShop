import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/user_admin_controller.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class UserAdminProfile extends GetView<UserAdminController> {
  UserAdminProfile({super.key});

  // User user = Get.arguments;
  String image = Get.arguments;



  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'پروفایل کاربری',
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
        child: Column(
          children: [
            SizedBox(height:10),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                 //   backgroundColor: kLightGreyColor,
                    radius: 60,
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: image != ''
                              ? Image.network(
                            'http://10.0.2.2:8000/image/${image}',
                                  fit: BoxFit.cover,
                                )
                              : FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: const AssetImage(
                                    'assets/images/userDefult.png',
                                  ),
                                  image: NetworkImage(
                                    'http://10.0.2.2:8000/image/${image}',
                                  ),
                                ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: const Icon(Icons.camera_alt,color: kRedColor,),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: kGreenColor,thickness: 2,),

            const SizedBox(
              height: 20,
            ),
            MyTextFeild(controller: controller.nameController),

            const SizedBox(
              height: 20,
            ),
            MyTextFeild(controller: controller.telController),

            const SizedBox(
              height: 20,
            ),
            MyTextFeild(controller: controller.emailController),

            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: TextField(
                controller: controller.passController,
                obscuringCharacter: '\u25CF',
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'رمز عبور',
                  hintStyle: kHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kGreenColor),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                  suffixIcon: IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(
                        Icons.visibility_off_rounded),
                    color: Colors.grey,
                  ),

                ),
                // obscuringCharacter:obscuringCharacter!,
              ),
            ),


            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: TextField(
                controller: controller.confirmPassController,
                obscuringCharacter: '\u25CF',
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'رمز عبور',
                  hintStyle: kHintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kGreenColor),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                  suffixIcon: IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(
                        Icons.visibility_off_rounded),
                    color: Colors.grey,
                  ),

                ),
                // obscuringCharacter:obscuringCharacter!,
              ),
            ),


            const SizedBox(
              height: 20,
            ),
            MyButton(text: 'ویرایش اطلاعات', onTapped: (){}),

          ],
        ),
      ),
    );
  }
}

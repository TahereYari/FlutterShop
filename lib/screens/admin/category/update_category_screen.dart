import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/category_controller.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class UpdateCategoryScreen extends GetView<CategoryController> {
  UpdateCategoryScreen({super.key});

  String? image = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(' ویرایش دسته ${controller.cat.value.name} ',
            style: kHeaderText),
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
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const SizedBox(
                height: 20,
              ),
              Text(
                'نام دسته',
                style: kTextStyle,
              ),
              MyTextFeild(
                controller: controller.nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'توضیحات',
                style: kTextStyle,
              ),
              MyTextFeild(
                controller: controller.describController,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'تصویر',
                style: kTextStyle,
              ),
              // GestureDetector(
              //   onTap: () {
              //     controller.selectImage();
              //   },
              //   child: Center(
              //     child: controller.cat.value.image =='' &&
              //            controller.file.value.path == '-1'
              //         ? const CircleAvatar(
              //             radius: 40,
              //             backgroundColor: kGreenColor,
              //             child: Icon(
              //               Icons.add_rounded,
              //               color: Colors.white,
              //               size: 40,
              //             ),
              //           )
              //         : controller.file.value.path == '-1'
              //             ? Image.network(
              //                 ' http://10.0.2.2:8000/image/${controller.cat.value.image!}',
              //                 width: Get.width,
              //                 height: 200,
              //                 fit: BoxFit.cover,
              //               )
              //             : Image.file(
              //                 controller.file.value,
              //                 width: Get.width,
              //                 height: 200,
              //                 fit: BoxFit.cover,
              //               ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  controller.selectImage();
                },
                // child: Center(
                //   child: controller.cat.value.image ==null
                //
                //       ? const CircleAvatar(
                //     radius: 40,
                //     backgroundColor: kGreenColor,
                //     child: Icon(
                //       Icons.add_rounded,
                //       color: Colors.white,
                //       size: 40,
                //     ),
                //   )
                //      : Image.network(
                //     ' http://10.0.2.2:8000/image/${controller.cat.value.image}',
                //     width: Get.width,
                //     height: 200,
                //     fit: BoxFit.cover,
                //   )
                //
                // ),


                child: Center(
                    child: Image.asset(
                      'assets/images/lavazem.png',
                      width: Get.width,
                      height: 200,
                      fit: BoxFit.cover,
                    )

                ),
              ),
              const SizedBox(
                height: 60,
              ),
              MyButton(
                  text: 'ثبت',
                  onTapped: () {
                    controller.updateCategory(controller.cat.value.id!);
                  }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

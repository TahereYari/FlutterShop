import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/category_controller.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class AddCategoryScreen extends GetView<CategoryController> {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'افزودن دسته جدید',
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
        physics: BouncingScrollPhysics(),
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
                maxLines: 2,
                height: null,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'تصویر',
                style: kTextStyle,
              ),
              GestureDetector(
                onTap: () {
                  controller.selectImage();
                },
                child: Obx(
                  () => Center(
                    child: controller.file.value.path == '-1'
                        ? CircleAvatar(
                            radius: 40,
                            backgroundColor: kGreenColor,
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          )
                        : Image.file(
                            controller.file.value,
                            width: Get.width,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height:60,
              ),
              MyButton(
                  text: 'ثبت',
                  onTapped: () {
                    controller.createCategory();
                  }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

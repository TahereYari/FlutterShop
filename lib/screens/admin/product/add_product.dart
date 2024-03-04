
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/product_controller.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class AddProduct extends GetView<ProductController> {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'افزودن محصول جدید',
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
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'نوع دسته بندی',
                style: kTextStyle,
              ),
              Obx(
                () => SizedBox(
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

                    items: controller.dropdownCategoryList,
                    onChanged: (int? value) {
                      controller.dropDownValue.value = value!;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'نام محصول ',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.nameController),
              const SizedBox(
                height: 20,
              ),
              Text(
                'قیمت محصول',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.priceController),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' تعداد',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.numberController),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' ویژگی ها',
                style: kTextStyle,
              ),
              MyTextFeild(controller: controller.propertiesController,height: null,),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' تصویر',
                style: kTextStyle,
              ),
              GestureDetector(
                onTap: (){
                  controller.selectImage();
                },
                child: Obx(
                  () =>  Center(
                    child:
                     controller.file.value.path == '-1'
                   ?
                    CircleAvatar(
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
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MyButton(text: 'ثبت', onTapped: () {
                controller.createProduct();
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

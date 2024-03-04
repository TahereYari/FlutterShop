import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/category_controller.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';

class CategoryList extends GetView<CategoryController> {
   CategoryList({super.key});
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          controller.reset();
          Get.toNamed(AppRouts.addCategoryScreen);
        },
        backgroundColor: kBlueColor,
        child: const Icon(Icons.add,color: Colors.white,size: 30,),
      ),
      appBar: AppBar(

        backgroundColor: kLightBlueColor,
        title: Text(
          'لیست دسته بندی ها',
          style: kHeaderText
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
          itemCount: controller.categoryList.length,
          itemBuilder: (context, index) {
            Category catList = controller.categoryList[index];
            return ListTile(
              leading: Image.network(
                'http://10.0.2.2:8000/image/${catList.image}',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                catList.name ?? '',
                style: kTextStyle,
              ),
              subtitle: Text(catList.description!.length > 15
                  ? '${catList.description!.substring(0, 15)}...'
                  : catList.description ?? ''),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.editCategory(catList.id!);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: kGreenColor,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        StaticMethodes.deleteSnackBar('دسته', 'دسته',
                            () => controller.deleteCategory(catList.id!));
                        //controller.deleteCategory(catList.id!);
                      },
                      icon:
                          const Icon(Icons.delete, color: kRedColor, size: 30),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 2.0,
          ),
        ),
      ),
    );
  }
}

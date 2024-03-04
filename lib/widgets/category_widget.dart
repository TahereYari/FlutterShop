import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/category.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/widget_loading.dart';

class CategoryWidget extends GetView<HomeController> {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دسته بندی ها',
                style: kHeaderText.copyWith(fontSize: 20, color: kBlueColor),
              ),
              // InkWell(
              //   onTap: () {},
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   child: Text(
              //     'مشاهده همه',
              //     style: kHeaderText.copyWith(
              //       fontSize: 20,
              //       color: kGreenColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: Obx(
                () => controller.newProducts.isEmpty
                ? const Center(
              child: WidgetLoading(),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoryImages.length,
              itemBuilder: (BuildContext context, int index) {
                Category category = controller.categoryImages[index];


                return Container(

                  color: Colors.white10,
                  width: 200,
                  margin: EdgeInsets.only(
                    right: controller.newProducts.first.id == category.id
                        ? 0
                        : 5,
                    left: controller.newProducts.last.id == category.id
                        ? 0
                        : 5,
                  ),
                  child: InkWell(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                    onTap: () {
                      controller.categoryProducts.clear();
                      controller.getCategoryProduct(category.id!);
                      Get.toNamed(AppRouts.productCategory,arguments: category.name);
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius:60,
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    'http://10.0.2.2:8000/image/${category.image}',
                                    height: 120,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Center(
                            child: Text(
                              category.name!,
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Spacer(),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

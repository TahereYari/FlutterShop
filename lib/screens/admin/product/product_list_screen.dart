import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/product_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';

class ProductListScreen extends GetView<ProductController> {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRouts.addProduct);
        },
        backgroundColor: kBlueColor,
        child: const Icon(Icons.add,color: Colors.white,size: 30,),
      ),
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'لیست محصولات',
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
      child: Obx(() => ListView.separated(
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              Product product = controller.productList[index];
              String? categoryName = controller.categorylist
                  .where((category) => category.id == product.categoryId)
                  .first
                  .name;
              return ListTile(
                leading: Image.network(
                  'http://10.0.2.2:8000/image/${product.image}',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  product.name!,
                  style: kTextStyle,
                ),
                subtitle: Text(
                  product.propertise!.length > 15
                      ? '${product.propertise!.substring(0,15)}...'
                      : product.propertise!,

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
                          StaticMethodes.deleteSnackBar('محصول', product.name!,
                              () => controller.deleteProduct(product.id!));
                          //controller.deleteCategory(catList.id!);
                        },
                        icon: const Icon(Icons.delete,
                            color: kRedColor, size: 30),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed(
                    AppRouts.adminProductScreen,
                    arguments: product,
                    parameters: {'categoryName' : categoryName!}
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          )),
    );
  }
}

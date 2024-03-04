
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/controllers/search_controller.dart';
import 'package:myshop/models/Product.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class FrontSearchScreen extends GetView<SearchScreenController> {
  const FrontSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      controller.searchController.clear();
      controller.productList.clear();
      return true;
    },
    child: BaseWidget(

      child: Obx(
       ()=> Column(
         mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: kLightGreyColor,
                      prefixIcon: InkWell(
                        onTap: () {


                        },
                        borderRadius: BorderRadius.circular(20),
                        child: const Icon(
                          Icons.search_rounded,
                          size: 20,
                        ),
                      ),
                      hintText: 'جست و جو ...',
                      hintStyle: kTextStyle,),
                  ),
                  SizedBox(height: 10,),
                  MyButton(text: 'جست و جو', onTapped: (){   controller.search();})
                ],
              ),

            ),
            if (controller.productList.isEmpty) ...[
              Expanded(
                child: Center(
                  child: Text(
                    'جستجو را براساس نوع دسته انجام دهید.',
                    style: kTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                // child: ListView.builder(
                //   itemCount: controller.productList.length,
                //     itemBuilder: (context, index) {
                //       Product product = controller.productList[index];
                //       return ListTile(
                //         leading: Image.network(
                //           'http://10.0.2.2:8000/image/${product.image}',
                //           width: 60,
                //           height: 60,
                //           fit: BoxFit.cover,
                //         ),
                //         title: Text(product.name ?? ''),
                //         subtitle: Text(product.price.toString()),
                //         onTap: (){
                //           Get.find<HomeController>().previewProduct(product!.id!);
                //         },
                //
                //       );
                //     },),

                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: List.generate(
                    controller.productList.length,
                        (index) {
                      Product product = controller.productList[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Future.delayed(Duration(milliseconds: 100),
                                (){
                                  Get.find<HomeController>().previewProduct(product!.id!);
                            },
                          );

                        },
                        child: Container(
                          decoration: BoxDecoration(
                           // color: controller.color[controller.random.nextInt(10)],
                            color: kLightGreenColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.redAccent,
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  'http://10.0.2.2:8000/image/${product.image}',
                                  height: 80,
                                  width: Get.width,
                                  fit: BoxFit.fitWidth,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product.name!,
                                  style: kHeaderText.copyWith(
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  product.price.toString(),
                                  style: kHeaderText.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],


          ],
        ),
      ),
    ));
  }
}

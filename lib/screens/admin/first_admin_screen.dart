import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/admin_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/controllers/user_admin_controller.dart';
import 'package:myshop/controllers/user_controller.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/stack_widget.dart';

class FirstAdminScreen extends GetView<AdminController> {
  FirstAdminScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Obx(
                    ()=>  Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius:40,
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child:  controller.store.value.image!=null

                                ? FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                  'assets/images/shop.png',
                                ),
                                image: NetworkImage(
                                  'http://10.0.2.2:8000/image/${controller.store.value.image}',
                                ),
                              )
                                  : Image.asset(
                              'assets/images/shop.png',
                              fit: BoxFit.cover,
                            )
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //     'فروشگاه ${controller.store.value.name!}',style: kTextStyle.copyWith(fontWeight: FontWeight.bold),),
                        Text(
                          'فروشگاه رز ',style: kTextStyle.copyWith(fontWeight: FontWeight.bold),),

                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Get.find<UserAdminController>().editActiveUser(controller.activeUser.value.id!);

                  // Get.toNamed(AppRouts.userAdminProfileScreen , arguments: controller.activeUser.value!);
                },
                child: Obx(
                      ()=>  Row(
                    children: [
                      CircleAvatar(
                        radius:20,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:  controller.activeUser.value.image!=null
                                  ?Image.network(
                                'http://10.0.2.2:8000/image/${controller.activeUser.value.image}',

                                fit: BoxFit.cover,
                              )
                                  :FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                  'assets/images/userDefult.png',
                                ),
                                image: NetworkImage(
                                  'http://10.0.2.2:8000/image/${controller.activeUser.value.image}',
                                ),
                              )
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          ' ${controller.activeUser.value.name!}',style: kTextStyle,),
                     ),
                      Spacer(),
                      Text('خروج'),
                      IconButton(onPressed: (){Get.find<UserController>().logOut();}, icon: Icon(Icons.exit_to_app_rounded)),
                    
                    ],
                  ),

                ),
              ),
            ),
            const Divider(color: kGreenColor,thickness: 1,),

            const SizedBox(
              height: 10,
            ),

            ListTile(
              title: const Text('صفحه اصلی'),
              leading: const Icon(
                Icons.home,
                color: kGreenColor,
              ),
              onTap: () {},
            ),
            const Divider(
              thickness: 2,
            ),

            ListTile(
              title: const Text('اطلاعات فروشگاه'),
              leading: const Icon(
                Icons.storefront_outlined,
                color: kGreenColor,
              ),
              onTap: () {
                controller.getStore();
                Get.toNamed(AppRouts.storeScreen);
              },
            ),
            const Divider(
              thickness: 2,
            ),

            ListTile(
              title: const Text('دسته ها'),
              onTap: () {
                Get.toNamed(AppRouts.categoryList);
              },
              leading: const Icon(
                Icons.category_sharp,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              title: const Text('محصولات'),
              onTap: () {
                Get.toNamed(AppRouts.productListScreen);
              },
              leading: const Icon(
                Icons.production_quantity_limits_sharp,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              title: const Text('تخفیفات'),
              onTap: () {
                Get.toNamed(AppRouts.listDiscountScreen);
              },
              leading: const Icon(
                Icons.discount_rounded,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              title: const Text('تخفیف براساس کد'),
              onTap: () {
                Get.toNamed(AppRouts.listOffCodeScreen);
              },
              leading: const Icon(
                Icons.discount_rounded,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              title: const Text('کاربران'),
              onTap: () {
                Get.toNamed(AppRouts.userListAdmin);
              },
              leading: const Icon(
                Icons.account_circle,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              title: const Text('فاکتورها'),
              onTap: () {
                Get.toNamed(AppRouts.invoiceListScreen);
              },
              leading: const Icon(
                Icons.inventory_outlined,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),

            ListTile(
              title: const Text('نظرات کاربران'),
              onTap: () {
                Get.toNamed(AppRouts.commentListScreen);
              },
              leading: const Icon(
                Icons.comment_rounded,
                color: kGreenColor,
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(height: 30,),

            Spacer(),
          ],
        ),
      ),
      appBar: AppBar(title:
          Text('فروشگاه رز',style: kHeaderText,),
        backgroundColor: kLightBlueColor,
        elevation: 0,
        actions: [
          IconButton(onPressed:(){
            Get.toNamed(AppRouts.homeScreen);
          }, icon: Icon(Icons.reset_tv_outlined))
        ],

    //  Text( 'فروشگاه ${Get.find<HomeController>().store.value.name!}'),
     ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  StackWidget(
                    color: kBlueColor,
                    text1: 'تعداد کاربران',
                    text2: controller.userCount.value!.toString(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  StackWidget(
                    color: kLightOrangeColor,
                    text1: 'تعداد کاربران سایت',
                    text2: controller.userUser.value!.toString(),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  StackWidget(
                    color: kGreenColor,
                    text1: 'تعداد کاربران مدیریت',
                    text2: controller.userNotUser.value!.toString(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  StackWidget(
                    color: kRedColor,
                    text1: 'تعداد کل محصولات',
                    text2: controller.products.value!.toString(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

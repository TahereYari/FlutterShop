import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/admin_controller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/controllers/user_admin_controller.dart';
import 'package:myshop/controllers/user_controller.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class FirstScreenFront extends GetView<HomeController> {
  FirstScreenFront({super.key});

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
                () => Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40,
                            child: SizedBox(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: controller
                                                .store
                                                .value
                                                .image !=
                                            null
                                        ? Image.network(
                                      'http://10.0.2.2:8000/image/${controller.store.value.image}',
                                      fit: BoxFit.cover,
                                    )
                                   : FadeInImage(
                                            fit: BoxFit.cover,
                                            placeholder: const AssetImage(
                                              'assets/images/shop.png',
                                            ),
                                            image: NetworkImage(
                                              'http://10.0.2.2:8000/image/${controller.store.value.image}',
                                            ),
                                          )
                                       ,),),
                          ),
                        ),
                        // Text(
                        //   'فروشگاه ${Get.find<AdminController>().store.value.name!}',
                        //   style:
                        //       kTextStyle.copyWith(fontWeight: FontWeight.bold),
                        // ),

                        Text(
                          'فروشگاه رز',
                          style:
                              kTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.find<UserAdminController>().editActiveUser(
                      Get.find<AdminController>().activeUser.value.id!);

                  // Get.toNamed(AppRouts.userAdminProfileScreen , arguments: controller.activeUser.value!);
                },
                child: Obx(
                  () => Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Get.find<AdminController>()
                                          .activeUser
                                          .value
                                          .image !=null

                                  ?  FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                  'assets/images/userDefult.png',
                                ),
                                image: NetworkImage(
                                  'http://10.0.2.2:8000/image/${Get.find<AdminController>().activeUser.value.image}',
                                ),
                              )
                              :Image.network(
                                      'http://10.0.2.2:8000/image/${Get.find<AdminController>().activeUser.value.image}',
                                      fit: BoxFit.cover,
                                    )

                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          '${Get.find<AdminController>().activeUser.value.name!}',
                          style: kTextStyle,
                        ),
                      ),
                      Spacer(),
                      Text('خروج'),
                      IconButton(
                          onPressed: () {
                            Get.find<UserController>().logOut();
                          },
                          icon: Icon(Icons.exit_to_app_rounded)),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: kGreenColor,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text('علاقه مندی های من'),
              leading: const Icon(
                Icons.favorite_outlined,
                color: kGreenColor,
              ),
              onTap: () {
                Get.find<HomeController>().favoriteList.clear();
                Get.find<HomeController>().getFavorite();
                Get.toNamed(AppRouts.favoriteScreen);
              },
            ),
            ListTile(
              title: const Text('لیست خریدهای من'),
              leading: const Icon(
                Icons.shopping_basket_sharp,
                color: kGreenColor,
              ),
              onTap: () {
                Get.find<HomeController>().getMyBasket();

                Get.toNamed(AppRouts.myBasketScreen);
              },
            ),
            Spacer(),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          'فروشگاه رز',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed:(){
            Get.toNamed(AppRouts.homeScreen);
          }, icon: Icon(Icons.reset_tv_outlined))
        ],
      ),
      body: Obx(
        () => PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: controller.homeWidget[controller.currentIndex.value],
        ),
      ),
      // bottomNavigationBar: Obx(
      //   () => AnimatedNotchBottomBar(
      //     notchBottomBarController:
      //         NotchBottomBarController(index: controller.currentIndex.value),
      //     bottomBarItems: const [
      //       BottomBarItem(
      //         inActiveItem: Icon(
      //           Icons.home_outlined,
      //           color: kRedColor,
      //         ),
      //         activeItem: Icon(
      //           Icons.home_filled,
      //           color: kGreenColor,
      //         ),
      //         itemLabel: 'صفحه اصلی',
      //       ),
      //       BottomBarItem(
      //         inActiveItem: Icon(
      //           Icons.shopping_cart_outlined,
      //           color: kRedColor,
      //         ),
      //         activeItem: Icon(
      //           Icons.shopping_cart,
      //           color: kGreenColor,
      //         ),
      //         itemLabel: 'سبد خرید',
      //       ),
      //       BottomBarItem(
      //         inActiveItem: Icon(
      //           Icons.search_rounded,
      //           color: kRedColor,
      //         ),
      //         activeItem: Icon(
      //           Icons.search_rounded,
      //           color: kGreenColor,
      //         ),
      //         itemLabel: 'جست و جو',
      //       ),
      //       // BottomBarItem(
      //       //   inActiveItem: Icon(
      //       //     Icons.account_circle_outlined,
      //       //     color: kRedColor,
      //       //   ),
      //       //   activeItem: Icon(
      //       //     Icons.account_circle,
      //       //     color: kGreenColor,
      //       //   ),
      //       //   itemLabel: 'پروفایل',
      //       // ),
      //
      //     ],
      //
      //     durationInMilliSeconds: 500,
      //     color: kGreyColor,
      //
      //
      //     onTap: (value) {
      //       controller.changeIndex(value);
      //     },
      //   ),
      // ),

      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          items: const [
            Icon(
              Icons.home_outlined,
              color: kGreenColor,
            ),
            Icon(
              Icons.shopping_cart_outlined,
              color: kGreenColor,
            ),
            Icon(
              Icons.search_rounded,
              color: kGreenColor,
            ),
          ],
          height: 60,
          backgroundColor: Colors.white,
          color: kPhirozeColor,
          buttonBackgroundColor: kLightGreenColor,
          index: controller.currentIndex.value,
          onTap: (value) {
            controller.changeIndex(value);
          },
          animationDuration: const Duration(milliseconds: 400),
        ),
      ),
    );
  }
}

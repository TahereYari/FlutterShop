import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/widgets/widget_loading.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends GetView<HomeController> {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        height: 180,
        child: Stack(

            children: [
              controller.imageSlider.isEmpty
              ? Center(child: WidgetLoading(),)
              :
          CarouselSlider(
            items: controller.imageSlider,
            carouselController: controller.carouselController.value,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.2,
                onPageChanged: (index, reason) {
                  controller.onChangeSlide;
                }),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            child: AnimatedSmoothIndicator(
              activeIndex: controller.currentSlide.value,
              count: controller.productImageList.length,
              axisDirection: Axis.horizontal,
              effect: const ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.white),
              onDotClicked: controller.onDotClick,
            ),
          )

        ]),
      ),
    );
  }
}

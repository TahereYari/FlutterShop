import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/offcode_controller.dart';
import 'package:myshop/models/offCode.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';

class OffCodeList extends GetView<OffCodeController> {
  const OffCodeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRouts.addOffCodeScreen);
          },
          backgroundColor: kBlueColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        appBar: AppBar(
          backgroundColor: kLightBlueColor,
          title: Text(
            'لیست تخفیفات براساس کد',
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
        child: Obx(
          () => ListView.separated(
            itemCount: controller.offCodeList.length,
            itemBuilder: (BuildContext context, int index) {
              OffCode offCode = controller.offCodeList[index];

              return ListTile(
                title: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'کد تخفیف ',
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                      child: Text(offCode.code!),
                    ),
                  ],
                ),
                subtitle: SingleChildScrollView(
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Expanded(child:Text('تخفیف(ریال): ', style: kTextStyle.copyWith(fontWeight: FontWeight.bold))),
                          Expanded(child: Text(offCode.price!.toString())),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'تاریخ شروع: ',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          )),
                          Expanded(child: Text(offCode.satartdate!)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'تاریخ پایان: ',
                            style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                          )),
                          Expanded(child: Text((offCode.enddate!))),
                        ],
                      ),
                    ],
                  ),
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
                          // StaticMethodes.deleteSnackBar('محصول', product.name!,
                          //         () => controller.deleteProduct(product.id!));
                          //
                        },
                        icon: const Icon(Icons.delete,
                            color: kRedColor, size: 30),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              color: kGreenColor, thickness: 2,
            ),
          ),
        ));
  }
}

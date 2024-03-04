import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/discount_controller.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


class AddDiscountScreen extends StatelessWidget {
  AddDiscountScreen({super.key});

  DiscountController controller = Get.find<DiscountController>();
 // String selectedDate = Jalali.now().toJalaliDateTime();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text(
          'افزودن تخفیف',
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
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'نام محصول ',
              style: kTextStyle,
            ),
            Obx(() => SizedBox(
                  width: Get.width - 40,
                  child: DropdownButton(
                      value: controller.dropDownValue.value,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 0,
                      style: kTextStyle,
                      underline: Container(
                        height: 2,
                        color: kGreenColor,
                      ),
                      items: controller.dropDownProductList.value,
                      onChanged: (int? value) {
                        controller.dropDownValue.value = value!;
                      }),
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'میزان تخفیف بر حسب درصد ',
              style: kTextStyle,
            ),
            MyTextFeild(controller: controller.precentController),
            SizedBox(
              height: 20,
            ),


            TextButton(
              onPressed: () async {
                controller.picked = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1385, 8),
                    lastDate: Jalali(1450, 9),
                    initialEntryMode: PDatePickerEntryMode.calendarOnly,
                    initialDatePickerMode: PDatePickerMode.year,
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          dialogTheme: const DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (controller.picked != null && controller.picked != controller.fromdate) {
                  controller.fromController.text =controller.picked!.toJalaliDateTime();
                }
              },
              child: Text('از تاریخ'),
            ),
            MyTextFeild(controller: controller.fromController),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                controller.picked2 = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),

                    firstDate: Jalali(1385, 8),
                    lastDate: Jalali(1450, 9),
                    initialEntryMode: PDatePickerEntryMode.calendarOnly,
                    initialDatePickerMode: PDatePickerMode.year,
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          dialogTheme: const DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (controller.picked2 != null && controller.picked2 != controller.todate) {
                  controller.toController.text = controller.picked2!.toJalaliDateTime();
                }
              },
              child: Text('تا تاریخ'),
            ),
            MyTextFeild(controller: controller.toController),
            SizedBox(
              height: 40,
            ),
            MyButton(text: 'ثبت', onTapped: () {controller.addDiscount();}),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/invoice_controller.dart';
import 'package:myshop/models/basket.dart';
import 'package:myshop/models/invoice.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/widget_loading.dart';

class InvoiceListScreen extends GetView<InvoiceController> {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'لیست فاکتورها',
            style: kHeaderText,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'ارسال نشده ها',),
              Tab(text: 'ارسال شده ها'),
            ],
            indicatorColor: kGreenColor,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body:  TabBarView(children: [
          // controller.invoiceNotSend.isEmpty
          // ?Center(child: WidgetLoading(),)
          // :
          Obx(() => ListView.separated(
              itemCount: controller.invoiceNotSend.length,
              itemBuilder: (context, index) {
                Basket basket = controller.invoiceNotSend[index];
                return ListTile(
                  title: Row(
                    children: [
                      Text('شماره فاکتور  ' ,  style: kTextStyle.copyWith(fontWeight: FontWeight.bold ),),
                      Text(basket.invoiceNumber.toString() ,style: kTextStyle.copyWith(fontSize: 16),),
                    ],
                  ),

                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text('تاریخ خرید : '  , style: kTextStyle.copyWith(fontWeight: FontWeight.bold ),),
                          Text(basket.createdAt! ,style: kTextStyle.copyWith(fontSize: 16),),
                        ],
                      ),
                      Row(
                        children: [
                          Text('میزان خرید  :' ,  style: kTextStyle.copyWith(fontWeight: FontWeight.bold ),),
                          Text(basket.price.toString(),style: kTextStyle.copyWith(fontSize: 16),),
                        ],
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          IconButton(
                            onPressed: () {
                              controller.invoiceProduct(basket.id!);
                              Get.toNamed(AppRouts.invoiceProductScreen);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye_outlined,
                              color: kGreenColor,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                          controller.invoiceSendBaskt(basket.id!);

                            },
                            icon:
                            const Icon(Icons.send, color: kRedColor, size: 30),
                          ),
                        ],
                      ),
                    ],
                  ),

                );


              },
              separatorBuilder: (context, index) => Divider(
                    color: kGreenColor,
                  ),
             )),
          // controller.invoiceSend.isEmpty
          // ?Center(child: WidgetLoading(),)
          // :
          Obx(() => ListView.separated(
            itemCount: controller.invoiceSend.length,
            itemBuilder: (context, index) {
              Basket basket = controller.invoiceSend[index];
              return ListTile(
                title: Row(
                  children: [
                    Text('شماره فاکتور  ' , style: kTextStyle.copyWith(fontWeight: FontWeight.bold )),
                    Text(basket.invoiceNumber.toString() ,style: kTextStyle.copyWith(fontSize: 16),),
                  ],
                ),

                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text('تاریخ خرید : ' , style: kTextStyle.copyWith(fontWeight: FontWeight.bold )),
                        Text(basket.createdAt! ,style: kTextStyle.copyWith(fontSize: 16),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('میزان خرید  :' , style: kTextStyle.copyWith(fontWeight: FontWeight.bold ),),
                        Text(basket.price.toString(),style: kTextStyle.copyWith(fontSize: 16),),
                      ],
                    ),



                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.basketProductlist.clear();
                             controller.invoiceProduct(basket.id!);
                             Get.toNamed(AppRouts.invoiceProductScreen);
                          },
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: kGreenColor,
                            size: 30,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),

              );


            },
            separatorBuilder: (context, index) => Divider(
              color: kGreenColor,
            ),
          )),
        ]),
      ),
    );
  }
}

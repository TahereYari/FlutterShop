

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/comment_cotroller.dart';
import 'package:myshop/models/comment.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/widget_loading.dart';

class CommentListScreen extends GetView<CommentController> {
  const CommentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kLightBlueColor,
        title: Text('لیست نظرات', style: kHeaderText),
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      child:
      // controller.commentList.isEmpty
      //   ? const Center(child: WidgetLoading(),)
      // :
      Obx(() => ListView.separated(
            itemCount: controller.commentList.length,
            itemBuilder: (context, index) {
              Comment comment = controller.commentList[index];
              String? productName = controller.productList
                  .where((product) => product.id == comment.productId)
                  .first
                  .name;

              return ListTile(
                title: Row(
                  children: [
                    Text('نام محصول:  ' ,style: kHeaderText,),
                    Text(productName! ,style: kTextStyle.copyWith(fontSize: 16),),
                  ],
                ),

                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text('نکات مثبت : ' ,style: kHeaderText,),
                        Text(comment.posetive! ,style: kTextStyle.copyWith(fontSize: 16),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('نکات منفی :' ,style: kHeaderText,),
                        Text(comment.negative!,style: kTextStyle.copyWith(fontSize: 16),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('دیدگاه : ' ,style: kHeaderText,),
                        Text(comment.comment! ,style: kTextStyle.copyWith(fontSize: 16),),
                      ],
                    ),

                    Row(
                      children: [
                        Text('نوع نمایش : ' ,style: kHeaderText,),
                        comment.preview == 0
                        ?Text('نمایش داده نمیشود' ,style: kTextStyle.copyWith(fontSize: 16),)
                        :Text('نمایش داده میشود' ,style: kTextStyle.copyWith(fontSize: 16),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                          controller.commentActivity(comment.id!);
                          },
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: kGreenColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.deleteComment(comment.id!);

                          },
                          icon:
                          const Icon(Icons.delete, color: kRedColor, size: 30),
                        ),
                      ],
                    ),
                  ],
                ),


              );
            },
            separatorBuilder: (context, index) => const Divider(
              color: kGreenColor,
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/comment_cotroller.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/comment.dart';
import 'package:myshop/widgets/base_widget.dart';
import 'package:myshop/widgets/my_button.dart';
import 'package:myshop/widgets/my_text_feild.dart';

class PreviewProduct extends GetView<HomeController> {
  PreviewProduct({super.key});

  bool onTappedComment = true;
  bool onTappedAddComment = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: Text(
          '${controller.productOne.value.name!}',
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
     // padding: 0,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: SizedBox(
          height: Get.height,
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                'http://10.0.2.2:8000/image/${controller.productOne.value.image}',
                height: 200,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Text(
                      'نام:',
                      style: kHeaderText.copyWith(fontSize: 23),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      controller.productOne.value.name!,
                      style: kTextStyle,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Text(
                      ' تعداد:',
                      style: kHeaderText.copyWith(fontSize: 23),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      controller.productOne.value.number!.toString(),
                      style: kTextStyle,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Text(
                      ' قیمت:',
                      style: kHeaderText.copyWith(fontSize: 23),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      ' ${controller.productOne.value.price!.toString()} ریال ',
                      style: kTextStyle,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    Text(
                      'ویژگی ها:',
                      style: kHeaderText.copyWith(fontSize: 23),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Text(
                      controller.productOne.value.propertise!,
                      style: kTextStyle,
                    )),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // controller.commentOfPtoduct.clear();
                        // controller.previewProduct(controller.productOne.value.id!);
                        StaticMethodes.bottomSheetCheckout();

                        // onTappedAddComment = false;
                        // onTappedComment = true;

                      },
                      child: Text(
                        ' نظرات',
                        style: kHeaderText.copyWith(
                            fontSize: 23, color: kBlueColor),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        onTappedComment = false;
                        onTappedAddComment = true;

                      },
                      child: Text(
                        'ثبت نظر جدید',
                        style: kHeaderText.copyWith(
                            fontSize: 23, color: kBlueColor),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kRedColor,
              ),

              // Visibility(
              //   visible: onTappedComment,
              //   child: Expanded(
              //     child: ListView.separated(
              //       itemCount: controller.commentOfPtoduct.length,
              //       itemBuilder: (context, index) {
              //         Comment comment = controller.commentOfPtoduct[index];
              //
              //         String? image = controller.userList
              //             .where((user) => user.id == comment.userId)
              //             .first
              //             .image;
              //         String? name = controller.userList
              //             .where((user) => user.id == comment.userId)
              //             .first
              //             .name;
              //
              //         return ListTile(
              //           title: Text(
              //             name!,
              //             style: kHintText,
              //           ),
              //           leading: CircleAvatar(
              //             radius: 20,
              //             child: SizedBox(
              //               width: 40,
              //               height: 40,
              //               child: ClipRRect(
              //                   borderRadius: BorderRadius.circular(20),
              //                   child: image != ''
              //                       ? Image.network(
              //                           'http://10.0.2.2:8000/image/${image}',
              //                           fit: BoxFit.cover,
              //                         )
              //                       : FadeInImage(
              //                           fit: BoxFit.cover,
              //                           placeholder: const AssetImage(
              //                             'assets/images/userDefult.png',
              //                           ),
              //                           image: NetworkImage(
              //                             'http://10.0.2.2:8000/image/${image}',
              //                           ),
              //                         )),
              //             ),
              //           ),
              //           subtitle: Text(
              //               // comment.comment!.length > 20
              //               // ? '${comment.comment!.substring(1, 20)}...'
              //               // :
              //               comment.comment!),
              //         );
              //       },
              //       separatorBuilder: (context, index) => const Divider(),
              //     ),
              //   ),
              // ),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.token == '-1'
                            ? Center(
                                child: Text(
                                  'برای ثبت نظر لطفا وارد حساب کاربری خود شوید',
                                  style: kTextStyle,
                                ),
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                        MyTextFeild(
                          controller:
                              Get.find<CommentController>().titleController,
                          hintText: 'عنوان',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextFeild(
                          controller: Get.find<CommentController>()
                              .positiveController,
                          hintText: 'نکات مثبت',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextFeild(
                          controller: Get.find<CommentController>()
                              .negativeController,
                          hintText: 'نکات منفی',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextFeild(
                          controller:
                              Get.find<CommentController>().scoreController,
                          hintText: 'امتیاز ',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextFeild(
                          controller:
                              Get.find<CommentController>().commentController,
                          hintText: 'نظر ',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(
                            text: 'ثبت',
                            onTapped: () {
                              Get.find<CommentController>().addComment(
                                  controller.productOne.value.id!);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/controllers/home_controller.dart';
import 'package:myshop/models/comment.dart';
import 'package:myshop/widgets/my_button.dart';

class StaticMethodes {
  static void deleteSnackBar(String title, String content,VoidCallback onTapped) {

    Get.defaultDialog(
      title:   ' حذف ${title}',
      content:Column(
        children: [
          Text(
            ' آیا از حذف ${content}  اطمینان دارید؟ ',
            style: kTextStyle,
          ),
          SizedBox(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  MyButton(text: 'بله', onTapped: onTapped,color: kGreenColor,width: 100.0,fontColor: Colors.white,),
                  SizedBox(width: 10,),
                  MyButton(text: 'خیر', onTapped: Get.back,color: kRedColor,width: 100.0,fontColor: Colors.white,),
                ],
              ),
            ),
          )
        ],
      ),



     //
     // confirm: MyButton(text: 'بله', onTapped: onTapped,color: kGreenColor,),
     // cancel: MyButton(text: 'خیر', onTapped: Get.back,color: kRedColor,),



    );


  }

  static void errorSnackBar(String title, String content) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: kHeaderText,
      ),
      messageText: Text(
        content,
        style: kTextStyle.copyWith(fontSize: 15),
      ),
      backgroundColor: Colors.tealAccent.withOpacity(0.2),
    );
  }
  static void SuccesSnackBar(String text) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [

          Image.asset(
            'assets/images/succes.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20,),
          Text(
            text,
            style: kHeaderText.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          ),

        ],

      ),

    );


  }
  static void unSuccesSnackBar(String text) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          Image.asset(
            'assets/images/unsucces.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20,),
          Text(
            text,
            style: kHeaderText.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );

  }

  static bool validateName(String name, String title) {
    if (name.isEmpty) {
      errorSnackBar('خطا', 'لطفا $title راوارد کنید.');
      return false;
    }
    return true;
  }

  static bool validateEmail(String email) {
    if (email.isEmpty) {
      errorSnackBar('خطا', 'لطفا ایمیل راوارد کنید.');
      return false;
    }
    else {
      bool status = GetUtils.isEmail(email);


      //اگر فرمت ایمیل را داشت
      if (!status) {
        errorSnackBar('خطا', 'لطفا ایمیل را صحیح وارد کنید.');
        return false;
      }
    }
    return true;
  }
  static bool validateNumber(String num,String content) {
    if (num.isEmpty) {
      errorSnackBar('خطا', 'لطفا ${content} راوارد کنید.');
      return false;
    }
    else {
      bool status = GetUtils.isNum(num);


      //اگر فرمت عدد را داشت
      if (!status) {
        errorSnackBar('خطا', 'لطفا ${content} را به صورت عدد وارد کنید.');
        return false;
      }
    }
    return true;
  }

  static bool validatePassword(String password) {
    if (password.isEmpty || password.length < 8) {
      errorSnackBar('خطا', 'لطفا رمز عبور را صحیح وارد کنید.');
      return false;
    }
    return true;
  }


  static bottomSheetCheckout() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SizedBox(height: Get.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                 Expanded(
                  child: ListView.separated(
                    itemCount: Get.find<HomeController>().commentOfPtoduct.length,
                    itemBuilder: (context, index) {
                      Comment comment = Get.find<HomeController>().commentOfPtoduct[index];

                      String? image = Get.find<HomeController>().userList
                          .where((user) => user.id == comment.userId)
                          .first
                          .image;
                      String? name = Get.find<HomeController>().userList
                          .where((user) => user.id == comment.userId)
                          .first
                          .name;

                      return ListTile(
                        title: Text(
                          name!,
                          style: kHintText,
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: image != ''
                                    ? Image.network(
                                  'http://10.0.2.2:8000/image/${image}',
                                  fit: BoxFit.cover,
                                )
                                    : FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: const AssetImage(
                                    'assets/images/userDefult.png',
                                  ),
                                  image: NetworkImage(
                                    'http://10.0.2.2:8000/image/${image}',
                                  ),
                                )),
                          ),
                        ),
                        subtitle: Text(
                          // comment.comment!.length > 20
                          // ? '${comment.comment!.substring(1, 20)}...'
                          // :
                            comment.comment!),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


}

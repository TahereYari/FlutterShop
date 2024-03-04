import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshop/constans/constans.dart';
import 'package:myshop/constans/method_static.dart';
import 'package:myshop/controllers/user_admin_controller.dart';
import 'package:myshop/models/User.dart';
import 'package:myshop/services/app_routs.dart';
import 'package:myshop/widgets/base_widget.dart';

class UserListAdmin extends GetView<UserAdminController> {
  UserListAdmin({super.key});

  //UserAdminController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRouts.addUserAdmin);
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
          'لیست کاربران',
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
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            User user = controller.userList[index];

            // String? roleName = controller.roleList
            //     .where((role) => role.id == user.roleId).first.name;
            // print('roleName');
            // print(roleName);


            return Expanded(
              child: ListTile(
                title:
                Row(
                  children: [
                    Expanded(child: Text('نام کاربری: ',style: kTextStyle,)),
                    Expanded(child:  Text(user.name!),),
                  ],

                ),
                subtitle: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('ایمیل: ',style: kTextStyle,)),
                          Expanded(child: Text(user.email!)),
                        ],

                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('نوع دسترسی: ',style: kTextStyle,)),
                          Expanded(child:user.roleId==3
                          ?Text( 'admin')
                          :Text( 'user')),

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
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(color: kGreenColor,),
        ),
      ),
    );
  }
}

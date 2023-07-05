import 'dart:io';
import 'package:divisorianijuanmain/consts/consts.dart';
import 'package:divisorianijuanmain/controllers/profileController.dart';
import 'package:divisorianijuanmain/views/splashscreen/loginScreenBg.dart';
import 'package:divisorianijuanmain/widgets/buttonNew.dart';
import 'package:divisorianijuanmain/widgets/textfieldLoginWidget.dart';
import 'package:get/get.dart';

class editProfileScreen extends StatelessWidget {
  final dynamic data;

  const editProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Expanded(
        child: Scaffold(
          appBar: AppBar(),
          body: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(imgProfile3, width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                    : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                buttonOur(
                    color: lightGolden,
                    onPress: () {
                      controller.changeImage(context);
                    },
                    textColor: whiteColor,
                    title: "Change"),
                Divider(),
                5.heightBox,
                customTextField(
                    controller: controller.nameController,
                    hint: nameHint,
                    title: name,
                    isPass: false),
                5.heightBox,
                customTextField(
                    controller: controller.oldpassController,
                    hint: passwordHint,
                    title: oldpass,
                    isPass: true),
                5.heightBox,
                customTextField(
                    controller: controller.newpassController,
                    hint: passwordHint,
                    title: newpass,
                    isPass: true),
                10.heightBox,
                controller.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(golden),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: buttonOur(
                            color: lightGolden,
                            onPress: () async {
                              controller.isLoading(true);
      
                              //if image not selected
                              if (controller.profileImgPath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                              }
      
                              //old password match
      
                              if (data['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthpassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword: controller.newpassController.text,
                                );
      
                                await controller.updatedProfile(
                                    imgUrl: controller.profileImageLink,
                                    name: controller.nameController.text,
                                    password: controller.newpassController.text);
                                VxToast.show(context, msg: "Changed!");
                              } else {
                                VxToast.show(context,
                                    msg: "Your old password is not match!");
                                controller.isLoading(false);
                              }
                            },
                            textColor: whiteColor,
                            title: "Save"),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(EdgeInsets.all(16))
                .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}

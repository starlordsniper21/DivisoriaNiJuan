// ignore_for_file: file_names

import 'package:divisorianijuanmain/Home/home.dart';
import 'package:divisorianijuanmain/consts/consts.dart';
import 'package:divisorianijuanmain/controllers/auth_controller.dart';
import 'package:divisorianijuanmain/signUpScreen.dart';
import 'package:divisorianijuanmain/views/splashscreen/loginScreenBg.dart';
import 'package:divisorianijuanmain/widgets/applogoWidget.dart';
import 'package:divisorianijuanmain/widgets/buttonNew.dart';
import 'package:divisorianijuanmain/widgets/textfieldLoginWidget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.01).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).black.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            //going to forget password class
                          },
                          child: forgetPass.text.make())),
                  5.heightBox,
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(golden),
                        )
                      : buttonOur(
                          color: lightGolden,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(false);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loginIn);
                                Get.offAll(Home());
                              } else {
                                controller.isLoading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  buttonOur(
                      color: lightGolden,
                      title: signUp,
                      textColor: whiteColor,
                      onPress: () {
                        Get.to(SignUpScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  //loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: List.generate(
                  //       3,
                  //       (index) => Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: CircleAvatar(
                  //               backgroundColor: lightGrey,
                  //               radius: 25,
                  //               child: Image.asset(
                  //                 socialIconList[index],
                  //                 width: 30,
                  //               ),
                  //             ),
                  //           )),
                  // ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}

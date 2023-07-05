// ignore_for_file: file_names

import 'package:divisorianijuanmain/Home/home.dart';
import 'package:divisorianijuanmain/controllers/auth_controller.dart';
import 'package:divisorianijuanmain/views/splashscreen/loginScreenBg.dart';
import 'package:divisorianijuanmain/widgets/applogoWidget.dart';
import 'package:divisorianijuanmain/widgets/buttonNew.dart';
import 'package:divisorianijuanmain/widgets/textfieldLoginWidget.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controll

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.01).heightBox,
            applogoWidget(),
            10.heightBox,
            "Sign in to $appname".text.fontFamily(bold).black.size(18).make(),
            20.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: retypePasswordController,
                      isPass: true),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: golden,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: golden,
                                )),
                            TextSpan(
                                text: " & ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                )),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: golden,
                                ))
                          ],
                        )),
                      )
                    ],
                  ),
                  controller.isLoading.value
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(golden),
                        )
                      : buttonOur(
                          color: isCheck == true ? lightGolden : lightGrey,
                          title: signUp,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isLoading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loginIn);
                                  Get.offAll(Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isLoading(false);
                              }
                            }
                            // created account class
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  buttonOur(
                      color: lightGolden,
                      title: "Go Back",
                      textColor: whiteColor,
                      onPress: () {
                        Navigator.pop(context);
                      }).box.width(context.screenWidth - 50).make(),
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

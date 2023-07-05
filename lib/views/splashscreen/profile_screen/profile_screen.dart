import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divisorianijuanmain/consts/consts.dart';
import 'package:divisorianijuanmain/consts/list.dart';
import 'package:divisorianijuanmain/controllers/auth_controller.dart';
import 'package:divisorianijuanmain/controllers/profileController.dart';
import 'package:divisorianijuanmain/loginScreen.dart';
import 'package:divisorianijuanmain/services/DNJBot.dart';
import 'package:divisorianijuanmain/services/firestoreServices.dart';
import 'package:divisorianijuanmain/views/splashscreen/loginScreenBg.dart';
import 'package:divisorianijuanmain/views/splashscreen/profile_screen/components/details_card.dart';
import 'package:divisorianijuanmain/views/splashscreen/profile_screen/editProfileScreen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
        stream: FirestoreService.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(golden),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            return SafeArea(
              child: Column(
                
                children: [
                  
                  //edit profile button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.edit, color: whiteColor),
                    ).onTap(() {
                      controller.nameController.text = data['name'];

                      Get.to(editProfileScreen(data: data));
                    }),
                  ),
                  //user details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(imgProfile3,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageUrl'],
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(bold)
                                  .white
                                  .make(),
                              5.heightBox,
                              "${data['email']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: whiteColor,
                            ),
                          ),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(bold).white.make(),
                        ),
                      ],
                    ),
                  ),

                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailsCard(
                          count: data['cart_count'],
                          title: "in your cart",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: data['wishlist_count'],
                          title: "in your wishlist",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: data['order_count'],
                          title: "Your orders",
                          width: context.screenWidth / 3.4),
                    ],
                  ),

                  //button section

                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonList[index]
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .shadowSm
                      .make()
                      .box
                      .make(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(onPressed: (){
                            Get.to(dnjBot());
                          },
                          child: const Icon(Icons.help),
                          ),
                    ],
                  ),
                ),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}

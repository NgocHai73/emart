import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controller/auth_controller.dart';
import 'package:emart/controller/profile_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/profile_screen/component/details_card.dart';
import 'package:emart/views/profile_screen/edit_profile.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FireStoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];
                return SafeArea(
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                          size: 20,
                        )).onTap(() {
                          controller.profileImage.value = data['imageURL'];
                      controller.nameController.text = data['name'];
                      controller.passController.text = data['password'];
                      Get.to(() => EditProfile(data: data));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        data['imageURL'] == ''
                            ? Image.asset(imgProfile2,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.file(File(data['imageURL']),
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
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              5.heightBox,
                              "${data['email']}".text.white.make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor),
                          ),
                          onPressed: () async {
                            await Get.put(AuthController()).singoutMethod(
                              Get.offAll(() => const LoginScreen()),
                            );
                          },
                          child:
                              "logout".text.fontFamily(semibold).white.make(),
                        )
                      ],
                    ),
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailsCard(
                          count: data['cart_count'],
                          title: "In your cart",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: data['wishlist_count'],
                          title: "In your wishlist",
                          width: context.screenWidth / 3.4),
                      detailsCard(
                          count: data['order_count'],
                          title: "Your orders",
                          width: context.screenWidth / 3.4),
                    ],
                  ),
                  20.heightBox,
                  ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: lightGrey,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make());
                          },
                          itemCount: profileButtonList.length)
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make()
                ]));
              }
            }),
      ),
    );
  }
}

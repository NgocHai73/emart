import 'dart:io';

import 'package:emart/consts/consts.dart';
import 'package:emart/controller/profile_controller.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;

  const EditProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    Future<void> saveProfile() async {
      await controller.updateProfile(
        imgURL: controller.profileImage.value.isEmpty
            ? File(data['imageURL'])
            : File(controller.profileImage.value),
        name: controller.nameController.text,
        password: controller.passController.text,
      );
      VxToast.show(context, msg: "Profile Updated");

      Get.back();
    }

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageURL'] == '' && controller.profileImage.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : data['imageURL'] == '' && controller.profileImage.isEmpty
                    ? Image.network(
                        data['imageURL'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.network(
                        (controller.profileImage.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
              color: redColor,
              textColor: whiteColor,
              title: "Change",
              onPress: () {
                controller.changeImage(context);
              },
            ),
            Divider(),
            20.heightBox,
            customTextField(
              controller: controller.nameController,
              hint: "Enter Your Name",
              title: "Name",
              isPass: false,
            ),
            10.heightBox,
            customTextField(
              controller: controller.passController,
              hint: "Enter  Password",
              title: " Password ",
              isPass: false,
            ),
            10.heightBox,
            20.heightBox,
            controller.isloading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: redColor,
                      title: "Save",
                      textColor: whiteColor,
                      onPress: () {
                        saveProfile();
                        controller.isloading(true);
                      },
                    ),
                  )
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
    ));
  }
}

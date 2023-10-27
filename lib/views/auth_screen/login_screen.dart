import 'package:emart/consts/lists.dart';
import 'package:emart/controller/auth_controller.dart';
import 'package:emart/views/home_screen/home.dart';
import 'package:emart/widgets_common/appLogo_widget.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<void> loginButtonPressed(BuildContext context) async {
    var controller = Get.find<AuthController>();
    await controller.loginMethod(context: context).then((value) {
      if (value != null) {
        VxToast.show(context, msg: loggedin);
        Get.offAll(() => const Home());
      } else {
        controller.isloading(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "Login to $appname".text.fontFamily(bold).white.size(18).make(),
          10.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: "Enter Your Email",
                    title: "Email",
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                    hint: "Enter Your Password",
                    title: "Password",
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgotPassword.text.make())),
                5.heightBox,
                // ourButton().box.width(context.screenWidth - 50).make(),
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        color: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () {
                          controller.isloading(true);
                          loginButtonPressed(context);
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    color: lighGolden,
                    title: signup,
                    textColor: redColor,
                    onPress: () {
                      Navigator.pushNamed(context, 'signup');
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
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
        ]),
      ),
    ));
  }
}

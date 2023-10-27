import 'package:emart/consts/consts.dart';
import 'package:emart/controller/auth_controller.dart';
import 'package:emart/widgets_common/appLogo_widget.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../home_screen/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// ignore: non_constant_identifier_names

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  Future<void> signupFunction(BuildContext context) async {
    if (isCheck == true) {
      controller.isloading(true);
      try {
        await controller
            .singupMethod(
          context: context,
          email: emailController.text,
          password: passwordController.text,
        )
            .then((value) {
          return controller
              .storeUserData(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
          )
              .then((value) {
            VxToast.show(context, msg: loggedin);
            Get.offAll(() => const Home());
          });
        });
      } catch (e) {
        auth.signOut();
        // ignore: use_build_context_synchronously
        VxToast.show(context, msg: e.toString());
        controller.isloading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "SignUp to $appname".text.fontFamily(bold).white.size(18).make(),
          10.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: "Enter Your Name",
                    title: "Name",
                    controller: nameController,
                    isPass: false),
                customTextField(
                    hint: "Enter Your Email",
                    title: "Email",
                    controller: emailController,
                    isPass: false),
                customTextField(
                    hint: "Enter Your Password",
                    title: "Password",
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    hint: "Confirm Password",
                    title: "Confirm Password",
                    controller: confirmPasswordController,
                    isPass: true),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "I agree to the ",
                            style:
                                TextStyle(color: fontGrey, fontFamily: regular),
                          ),
                          TextSpan(
                            text: termAndCond,
                            style:
                                TextStyle(fontFamily: regular, color: redColor),
                          ),
                          TextSpan(
                            text: "&",
                            style:
                                TextStyle(fontFamily: regular, color: fontGrey),
                          ),
                          TextSpan(
                            text: privacyPolicy,
                            style:
                                TextStyle(fontFamily: regular, color: redColor),
                          ),
                        ],
                      )),
                    )
                  ],
                ),
                10.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        color: isCheck == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () {
                          signupFunction(context);
                        } // Gọi hàm tách riêng ở đây
                        ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                RichText(
                  text: const TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                          text: alreadyHaveAccount,
                          style: TextStyle(color: fontGrey)),
                      TextSpan(
                          text: login,
                          style: TextStyle(color: redColor, fontFamily: bold))
                    ],
                  ),
                ).onTap(() {
                  Navigator.pushNamed(context, 'login');
                })
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

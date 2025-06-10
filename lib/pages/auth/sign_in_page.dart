import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/base/custom_loader.dart';
import 'package:food_ordering/base/show_custom_snackbar.dart';
import 'package:food_ordering/controllers/auth_controller.dart';
import 'package:food_ordering/models/signup_body_model.dart';
import 'package:food_ordering/pages/auth/sign_up_page.dart';
import 'package:food_ordering/routes/route_helper.dart';
import 'package:food_ordering/widgets/app_text_field.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _login(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar("Nhập vào email của bạn", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar("Email không hợp lệ", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackbar("Nhập vào mật khẩu của bạn", title: "Mật khẩu");
      } else if (password.length < 6) {
        showCustomSnackbar("Mật khẩu phải từ 6 ký tự", title: "Mật khẩu");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    Container(
                      height: Dimensions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Xin chào",
                            style: TextStyle(
                              fontSize:
                                  Dimensions.font20 * 3 + Dimensions.font20 / 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Đăng nhập vào tài khoản của bạn",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      textController: emailController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                      textController: passwordController,
                      hintText: "Password",
                      icon: Icons.password,
                      isObscure: true,
                    ),
                    SizedBox(height: Dimensions.height20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                            text: "Đăng nhập vào tài khoản của bạn",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                      ],
                    ),

                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius30,
                          ),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Đăng nhập",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    RichText(
                      text: TextSpan(
                        text: "Chưa có tài khoản?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap =
                                      () => Get.to(
                                        () => SignUpPage(),
                                        transition: Transition.fade,
                                      ),
                            text: " Tạo tài khoản",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : CustomLoader();
        },
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/color.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/base/custom_loader.dart';
import 'package:food_ordering/base/show_custom_snackbar.dart';
import 'package:food_ordering/controllers/auth_controller.dart';
import 'package:food_ordering/models/signup_body_model.dart';
import 'package:food_ordering/widgets/app_text_field.dart';
import 'package:food_ordering/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpPage = ['google.png', 'x.png', 'facebook.png'];
    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar("Nhập vào tên của bạn", title: "Tên");
      } else if (phone.isEmpty) {
        showCustomSnackbar(
          "Nhập vào số điện thoại của bạn",
          title: "Số điện thoại",
        );
      } else if (email.isEmpty) {
        showCustomSnackbar("Nhập vào email của bạn", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar("Email không hợp lệ", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackbar("Nhập vào mật khẩu của bạn", title: "Mật khẩu");
      } else if (password.length < 6) {
        showCustomSnackbar("Mật khẩu phải từ 6 ký tự", title: "Mật khẩu");
      } else {
        showCustomSnackbar("Đã đăng ký", title: "Thông báo");
        SignupBody signUpBody = SignupBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success Registration");
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading
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
                    AppTextField(
                      textController: nameController,
                      hintText: "Name",
                      icon: Icons.email,
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                      textController: phoneController,
                      hintText: "Phone",
                      icon: Icons.email,
                    ),
                    SizedBox(height: Dimensions.height20),
                    GestureDetector(
                      onTap: () {
                        _registration(_authController);
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
                            text: "Đăng ký",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    RichText(
                      text: TextSpan(
                        recognizer:
                            TapGestureRecognizer()..onTap = () => Get.back(),
                        text: "Đã có tài khoản?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    RichText(
                      text: TextSpan(
                        text: "Sử dụng phương thức đăng nhập khác?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.all(8),
                          child: CircleAvatar(
                            radius: Dimensions.radius30,
                            backgroundImage: AssetImage(
                              "assets/images/" + signUpPage[index],
                            ),
                          ),
                        ),
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

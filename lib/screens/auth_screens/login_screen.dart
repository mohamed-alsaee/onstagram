import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:onstagram/widgets/inputs/app_input.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppInput(label: "Email", controller: emailController),
              AppInput(label: "Username", controller: usernameController),
              AppInput(label: "Name", controller: nameController),
              AppInput(label: "Pasword", controller: passwordController),
              AppInput(
                label: "Password Confirmation",
                controller: confirmPasswordController,
              ),
              AppButton(
                btnColor: blueColor,
                onPressed: () {},
                label: "تسجيل دخول",
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

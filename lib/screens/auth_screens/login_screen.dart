import 'package:emails_validator/emails_validator.dart';
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
  bool showPassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppInput(
                  label: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "email is required!";
                    }
                    if (!EmailsValidator.validate(v)) {
                      return "email is not valid!";
                    }
                    return null;
                  },
                ),
                AppInput(
                  label: "Phone",
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  digitsOnly: true,
                  customHint: "9X-XXX-XXXX",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "phone is required!";
                    }
  
                    if (v[0] == "0") {
                      return "phone should be with format 9X-XXX-XXXX";
                    }

                    if (v.length != 10) {
                      return "phone length is 10!";
                    }
                    return null;
                  },
                ),
                AppInput(
                  label: "Username",
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  validator: (v) {
                    return null;
                  },
                ),
                AppInput(
                  label: "Name",
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (v) {
                    return null;
                  },
                ),
                AppInput(
                  label: "Pasword",
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "password is required";
                    }

                    if (v.length < 8) {
                      return "password should be 8 chars or more";
                    }
                    return null;
                  },
                  showValue: showPassword,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                AppInput(
                  label: "Password Confirmation",
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "password is required";
                    }

                    if (v.length < 8) {
                      return "password should be 8 chars or more";
                    }

                    if (v != passwordController.text) {
                      return "password & Confirmation not mtahced";
                    }

                    return null;
                  },
                  showValue: showPassword,
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                AppButton(
                  btnColor: blueColor,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  label: "تسجيل دخول",
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

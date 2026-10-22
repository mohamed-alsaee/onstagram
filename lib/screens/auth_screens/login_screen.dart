import 'package:emails_validator/emails_validator.dart';
import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:onstagram/widgets/inputs/app_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "test@onstagram.comm",
  );
  TextEditingController passwordController = TextEditingController(
    text: "password",
  );

  @override
  Widget build(BuildContext context) {
    return Consumer2<DarkModeProvider, AuthProvider>(
      builder: (context, darkModeConsumer, authConsumer, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: darkModeConsumer.isDark
                        ? Colors.white24
                        : Colors.black12,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Provider.of<DarkModeProvider>(
                        context,
                        listen: false,
                      ).switchMode();
                    },
                    icon: Icon(
                      darkModeConsumer.isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),

                    AppButton(
                      btnColor: blueColor,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authConsumer
                              .login({
                                "email": emailController.text,
                                "password": passwordController.text,
                                "fcm_token": "x",
                              })
                              .then((loginResult) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: loginResult.first
                                        ? greenColor
                                        : redColor,
                                    content: Text(loginResult.last),
                                  ),
                                );
                              });
                        }
                      },
                      label: "تسجيل دخول",
                      isLoading: authConsumer.busy,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

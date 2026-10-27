import 'package:emails_validator/emails_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/helpers/functions.dart';
import 'package:onstagram/main.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:onstagram/widgets/inputs/app_input.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "test@onstagram.comm",
  );
  TextEditingController nameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController(
    text: "password",
  );

  String? message;
  bool availabe = false;
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
                    Text("Register"),
                    Image.asset(
                      "assets/horizontalLogo.png",
                      width: getSize(context).width * 0.5,
                    ),

                    AppInput(
                      customHint: "Name",
                      controller: nameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Name is required";
                        }

                        if (v.length < 2) {
                          return "Name must be more than 2 chars";
                        }
                        return null;
                      },
                      onChanged: () {},
                    ),

                    AppInput(
                      suffix: Icon(
                        Icons.check,
                        color: availabe ? greenColor : Colors.transparent,
                      ),
                      customHint: "Username",
                      controller: usernameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Name is required";
                        }

                        if (v.length < 2) {
                          return "Name must be more than 2 chars";
                        }
                        return null;
                      },
                      onChanged: () {
                        authConsumer
                            .checkUsername(usernameController.text)
                            .then((checkResult) {
                              message = checkResult.last;
                              availabe = checkResult.first;
                            });
                      },

                      underWidget: message != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                message!,
                                style: bodySmall.copyWith(
                                  color: availabe ? greenColor : redColor,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
  
                    AppInput(
                      customHint: "Email",
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
                      onChanged: () {},
                    ),

                    AppInput(
                      customHint: "Password",

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
                      onChanged: () {},
                    ),

                    AppButton(
                      btnColor: blueColor,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (availabe) {
                            await authConsumer
                                .register({
                                  "name": nameController.text,
                                  "username": usernameController.text,
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "fcm_token": "a",
                                })
                                .then((registerReult) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: registerReult.first
                                            ? greenColor
                                            : redColor,
                                        content: Text(registerReult.last),
                                      ),
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => ScreenRouter(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: redColor,
                                content: Text(
                                  "User name unavailabe choose another user name",
                                ),
                              ),
                            );
                          }
                        }
                      },
                      label: "Sign Up",
                      isLoading: authConsumer.busy,
                    ),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: bodyMedium.copyWith(color: Colors.grey),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Log in",
                      style: labelSmall.copyWith(color: blueColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

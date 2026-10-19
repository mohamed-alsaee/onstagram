import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';

class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              btnColor: blueColor,
              onPressed: () {},
              label: "First",
              isLoading: false,
            ),
            AppButton(
              isLoading: true,
              onPressed: () {},
              label: "Second",
              btnColor: Colors.grey,
            ),
            AppButton(onPressed: () {}, label: "Third", btnColor: Colors.red),
            AppButton(
              onPressed: () {},
              label: "Fourth",
              btnColor: Colors.white,
              txtColor: blueColor,
            ),
          ],
        ),
      ),
    );
  }
}

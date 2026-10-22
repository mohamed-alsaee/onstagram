import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/main.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => ScreenRouter()),
              (route) => false,
            );
          },
          label: "LOGOUT",
          btnColor: blueColor,
        ),
      ),
    );
  }
}

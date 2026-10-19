import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:onstagram/helpers/functions.dart';
import 'package:onstagram/screens/auth_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
                  "assets/horizontalLogo.png",
                  width: getSize(context).width * 0.5,
                )
                .animate(
                  onComplete: (v) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                )
                .fadeIn(
                  delay: Duration(milliseconds: 300),
                  duration: Duration(milliseconds: 600),
                )
                .fadeOut(
                  delay: Duration(seconds: 3),
                  duration: Duration(milliseconds: 600),
                ),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

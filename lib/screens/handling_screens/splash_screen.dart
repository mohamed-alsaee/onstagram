import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:onstagram/helpers/functions.dart';
import 'package:onstagram/main.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<DarkModeProvider>(context, listen: false).getFromStorage();
    super.initState();
  }

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
                      CupertinoPageRoute(builder: (context) => ScreenRouter()),
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

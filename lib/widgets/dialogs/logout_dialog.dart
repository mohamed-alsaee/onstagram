import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/main.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatefulWidget {
  const new({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, DarkModeProvider>(
      builder: (context, authConsumer, darkModeConsumer, _) {
        return AlertDialog(
          title: Text("Logout"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you sure you want to logout?"),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      isLoading: authConsumer.busy,
                      hPadding: 0,
                      onPressed: () async {
                        await authConsumer.logout().then((logoutResult) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: logoutResult.first
                                    ? greenColor
                                    : redColor,
                                content: Text(logoutResult.last),
                              ),
                            );
                            Timer(Duration(seconds: 3), () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ScreenRouter(),
                                ),
                                (route) => false,
                              );
                            });
                          }
                        });
                      },
                      label: "Yes",
                      btnColor: redColor,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: bodySmall.copyWith(
                          color: darkModeConsumer.isDark
                              ? whiteColor
                              : blackColor,
                        ),
                      ),
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

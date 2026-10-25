import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:onstagram/widgets/dialogs/logout_dialog.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, darkModeConsumer, _) {
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
            child: AppButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => LogoutDialog(),
                );
              },
              label: "LOGOUT",
              btnColor: blueColor,
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:onstagram/screens/auth_screens/login_screen.dart';
import 'package:onstagram/screens/handling_screens/splash_screen.dart';
import 'package:onstagram/screens/main_screens/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkModeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<DarkModeProvider>(
        builder: (context, darkModeConsumer, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: darkModeConsumer.isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: darkTheme,
            theme: theme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const new({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).initAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return authConsumer.authStatus == AuthStatus.authenticated
            ? ProfileScreen()
            : LoginScreen();
      },
    );
  }
}

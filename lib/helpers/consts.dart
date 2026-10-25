import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------------ API CONSTANTS ------------------

String baseUrl = "https://onstagramcourse.com";
String studentApiKey = "onsk_i8k7Yhar2gO6KNsfSswUYkrqnIJcdUHNRrRFPUIO";

// ------------------ COLORS CONSTANTS ------------------

Color blackColor = Color(0xff000000);
Color whiteColor = Color(0xffffffff);
Color blueColor = Color(0xff0095F6);

Color greenColor = Colors.green;
Color redColor = Color(0xffff0000);
Color warningColor = Colors.orange;

// ------------------ TEXT STYLES CONSTANTS ------------------

TextStyle displayLarge = GoogleFonts.cairo(
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

TextStyle displayMedium = GoogleFonts.cairo(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

TextStyle displaySmall = GoogleFonts.cairo(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

TextStyle labelLarge = GoogleFonts.cairo(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

TextStyle labelMedium = GoogleFonts.cairo(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle labelSmall = GoogleFonts.cairo(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

TextStyle bodyLarge = GoogleFonts.cairo(
  fontSize: 20,
  fontWeight: FontWeight.normal,
);

TextStyle bodyMedium = GoogleFonts.cairo(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

TextStyle bodySmall = GoogleFonts.cairo(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);

// ------------------ THEMES CONSTANTS ------------------

ThemeData theme = ThemeData(
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
    ),
    titleTextStyle: labelLarge.copyWith(color: blackColor),
    backgroundColor: whiteColor,
    contentTextStyle: bodyMedium.copyWith(color: blackColor),
  ),
  dividerColor: Colors.grey,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.grey.withValues(alpha: 0.5),
  ),
  textTheme: TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1),
    ),
  ),
  colorScheme: .fromSeed(seedColor: blueColor),
);

ThemeData darkTheme = ThemeData(
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
    ),

    titleTextStyle: labelLarge,
    backgroundColor: const Color.fromARGB(255, 31, 31, 31),
    contentTextStyle: bodyMedium,
  ),
  dividerColor: Colors.white30,

  iconTheme: IconThemeData(color: Colors.white),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white)),
  ),
  appBarTheme: AppBarThemeData(backgroundColor: Colors.black),
  scaffoldBackgroundColor: Colors.black,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.grey.withValues(alpha: 0.5),
  ),

  textTheme: TextTheme(
    displayLarge: displayLarge.copyWith(color: Colors.white),
    displayMedium: displayMedium.copyWith(color: Colors.white),
    displaySmall: displaySmall.copyWith(color: Colors.white),
    labelLarge: labelLarge.copyWith(color: Colors.white),
    labelMedium: labelMedium.copyWith(color: Colors.white),
    labelSmall: labelSmall.copyWith(color: Colors.white),
    bodyLarge: bodyLarge.copyWith(color: Colors.white),
    bodyMedium: bodyMedium.copyWith(color: Colors.white),
    bodySmall: bodySmall.copyWith(color: Colors.white),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1),
    ),
  ),
  colorScheme: .fromSeed(seedColor: blueColor),
);

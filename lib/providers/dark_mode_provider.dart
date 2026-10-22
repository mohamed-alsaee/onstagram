import 'package:flutter/foundation.dart';
import 'package:onstagram/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider extends BaseProvider {
  bool isDark = false;

  void getFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool("isdark") ?? false;
    // setBusy(false);  THIS OR setBusy(v) just for notifing consumers
    if (kDebugMode) {
      print("DARKMODE : $isDark");
    }
    notifyListeners();
  }

  void setToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isdark", isDark);
    getFromStorage();
  }

  void switchMode() {
    isDark = !isDark;
    setToStorage();
  }
}

import 'dart:convert';

import 'package:onstagram/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unintialized, authenticating, authenticated, unauthenticated }

class AuthProvider extends BaseProvider {
  AuthStatus authStatus = AuthStatus.unintialized;

  String? token;

  Future<void> initAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("user_token");

    if (token != null) {
      authStatus = AuthStatus.authenticated;
      notifyListeners();
    } else {
      authStatus = AuthStatus.unauthenticated;
      notifyListeners();
    }
  }

  Future<List> login(Map body) async {
    setBusy(true);
    final response = await api.post("/api/auth/login", body);

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(
        "user_token",
        json.decode(response.body)['data']['token'],
      );

      initAuth();
      setFailed(false);
      setBusy(false);
      return [true, json.decode(response.body)['message']];
    } else {
      setFailed(true);
      setBusy(false);
      initAuth();
      return [false, json.decode(response.body)['message']];
    }
  }

  // register() {}

  // logout() {}

  // checkusername() {}

  // updateUser() {}

  // getMe() {}
}

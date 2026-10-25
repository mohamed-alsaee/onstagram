import 'dart:convert';

import 'package:onstagram/models/user_profile_model.dart';
import 'package:onstagram/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unintialized, authenticating, authenticated, unauthenticated }

class AuthProvider extends BaseProvider {
  AuthStatus authStatus = AuthStatus.unintialized;
  String? token;

  UserProfileModel? currentUser;

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

  Future<List> register(Map body) async {
    setBusy(true);
    final response = await api.post("/api/auth/register", body);

    if (response.statusCode == 201) {
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

  Future<List> checkUsername(String un) async {
    // if (un == "") return [];
    setBusyMore(true);

    final response = await api.get("/api/auth/check-username?username=$un");

    var decodedData = json.decode(response.body);
    if (response.statusCode == 200 && decodedData['data']['available']) {
      setBusyMore(false);
      return [true, decodedData['message']];
    } else {
      setBusyMore(false);
      return [false, decodedData['message']];
    }
  }

  Future<List> logout() async {
    setBusy(true);

    final response = await api.post("/api/auth/logout", {});

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.clear();
      initAuth();
      setBusy(false);
      return [true, json.decode(response.body)['message']];
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      initAuth();
      setBusy(false);
      return [true, "Logout out via clearin Prefs"];
    }
  }

  // TODO WHY GET ME RETURN 401
  void getMe() async {
    setBusyMore(true);

    final response = await api.get("/api/auth/me");

    if (response.statusCode == 200) {
      currentUser = UserProfileModel.fromJson(
        json.decode(response.body)['data'],
      );

      setBusyMore(false);
    } else {
      currentUser = null;
      setBusyMore(false);
    }
  }

  // updateUser() {}
}

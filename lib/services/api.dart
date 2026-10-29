import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:onstagram/helpers/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<http.Response> get(String endPoint) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.get(
      Uri.parse(baseUrl + endPoint),
      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
        "X-Student-Api-Key": studentApiKey,
        "Authorization": "Bearer ${prefs.getString("user_token") ?? ""}",
      },
    );

    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- GET URL :$baseUrl$endPoint ---");
      print("--- GET STATUSCODE : ${response.statusCode}");
      print("--- GET RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }

    return response;
  }

  Future<http.Response> post(String endPoint, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse(baseUrl + endPoint),
      body: body,
      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
        "X-Student-Api-Key": studentApiKey,
        "Authorization": "Bearer ${prefs.getString("user_token") ?? ""}",
      },
    );
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- POST URL :$baseUrl$endPoint ---");
      print("--- POST STATUSCODE : ${response.statusCode}");
      print("--- POST RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }

  Future<http.Response> put(String endPoint, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.put(
      Uri.parse(baseUrl + endPoint),
      body: body,
      headers: {
        "Accept": "application/json",
        // "content-type": "application/json",
        "X-Student-Api-Key": studentApiKey,
        "Authorization": "Bearer ${prefs.getString("user_token") ?? ""}",
      },
    );
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- PUT URL :$baseUrl$endPoint ---");
      print("--- PUT STATUSCODE : ${response.statusCode}");
      print("--- PUT RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }

  Future<http.Response> delete(String endPoint, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.delete(
      Uri.parse(baseUrl + endPoint),
      body: body,
      headers: {
        "Accept": "application/json",
        "X-Student-Api-Key": studentApiKey,
        "Authorization": "Bearer ${prefs.getString("user_token") ?? ""}",
      },
    );
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- DELETE URL :$baseUrl$endPoint ---");
      print("--- DELETE STATUSCODE : ${response.statusCode}");
      print("--- DELETE RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }

  Future<http.Response> upload(
    String endPoint,
    File file,
    String purpose,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var uri = Uri.parse(baseUrl + endPoint);

    // 1. Create the multipart request
    var request = http.MultipartRequest('POST', uri);

    // 2. Add text fields
    // request.fields['file'] = file.path;
    request.fields['purpose'] = purpose;

    // 3. Add headers if required
    request.headers.addAll({
      "Accept": "application/json",
      "X-Student-Api-Key": studentApiKey,
      "Authorization": "Bearer ${prefs.getString("user_token") ?? ""}",
    });

    // 4. Attach the file
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // The key expected by your backend API
        file.path, // The local path to the file
      ),
    );

    // 5. Send the request
    var streamedResponse = await request.send();

    // 6. Parse the response
    var response = await http.Response.fromStream(streamedResponse);
    if (kDebugMode) {
      print("---- --- --- --- ");
      print("--- UPLOADER URL :$baseUrl$endPoint ---");
      print("--- UPLOADER STATUSCODE : ${response.statusCode}");
      print("--- UPLOADER RESPONSE : ${response.body}");
      print("---- --- --- --- ");
    }
    return response;
  }
}

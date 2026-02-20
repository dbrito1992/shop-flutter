import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> authenticate(
    String email,
    String password,
    String urlFragment,
  ) async {
    final urlApi =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyB4-hpFFQqDCWeHuort-whSxwzI-9h7nKQ";
    final response = await http.post(
      Uri.parse(urlApi),
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    print(jsonDecode(response.body));
  }

  Future<void> register(
    String email,
    String password,
    String urlFragment,
  ) async {
    await authenticate(email, password, urlFragment);
  }

  Future<void> login(String email, String password, String urlFragment) async {
    await authenticate(email, password, urlFragment);
  }
}

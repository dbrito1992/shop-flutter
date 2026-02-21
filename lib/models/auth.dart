import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/http_exception/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _email;
  String? _token;
  String? _uid;
  DateTime? _expiration;

  bool get isAuth {
    final isValid = _expiration?.isAfter(DateTime.now()) ?? false;
    return isValid;
  }

  String get email {
    return _email ?? '';
  }

  String get token {
    return _token ?? '';
  }

  String get uid {
    return _uid ?? '';
  }

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

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _email = body['email'];
      _uid = body['localId'];
      _expiration = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );
      _token = body['idToken'];
      notifyListeners();
    }
  }

  Future<void> register(
    String email,
    String password,
    String urlFragment,
  ) async {
    return authenticate(email, password, urlFragment);
  }

  Future<void> login(String email, String password, String urlFragment) async {
    return authenticate(email, password, urlFragment);
  }
}

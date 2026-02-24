import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/store.dart';
import 'package:shop/http_exception/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _email;
  String? _token;
  String? _uid;
  DateTime? _expiration;
  // ignore: unused_field
  Timer? _timerLogout;

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
      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'expiration': _expiration!.toIso8601String(),
        'uId': _uid,
      });
      _logoutAuto();
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    final dateExpirated = DateTime.parse(userData['expiration']);

    if (dateExpirated.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _expiration = dateExpirated;
    _uid = userData['uId'];
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

  void logout() {
    _email = null;
    _token = null;
    _uid = null;
    _expiration = null;
    clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void clearLogoutTimer() {
    _timerLogout = null;
  }

  void _logoutAuto() {
    clearLogoutTimer();
    final timeLogout = _expiration?.difference(DateTime.now()).inSeconds;
    _timerLogout = Timer(Duration(seconds: timeLogout ?? 0), logout);
  }
}

import 'dart:convert';

import '../services/http_utils/url_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final String _urlSignIn = '/users/sign_in.json';
  final String _urlSignUp = '/users.json';
  final String _urlVerify = '/users/me.json';

  Future<http.Response> login(String email, String password) async {
    try {
      final response = await http.post(Uri.https(url, _urlSignIn),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'password': password,
            }
          }));
      print('LOGIN USER: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // User user = User.fromJson(jsonDecode(response.body));
        // return user;
        return response;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<http.Response> autoLogin(String bearerToken) async {
    try {
      final response = await http.get(
        Uri.https(url, _urlVerify),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken,
        },
      );
      print('AUTO LOGIN USER: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // User user = User.fromJson(jsonDecode(response.body));
        // return user;
        return response;
      } else {
        throw Exception('Auto Login failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<http.Response> registerUser(String email, String password,
      String passwordConfirmation, String name, String lastName) async {
    try {
      final response = await http.post(Uri.https(url, _urlSignUp),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'user': {
              'email': email,
              'name': name,
              'lastname': lastName,
              'password': password,
              'password_confirmation': passwordConfirmation
            }
          }));
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Signup failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}

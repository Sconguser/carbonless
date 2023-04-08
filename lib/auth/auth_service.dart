import 'dart:convert';

import 'auth_models/user_model.dart';
import 'package:http/http.dart' as http;

import 'auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final String _url = 'stark-harbor-12710.herokuapp.com';
  final String _urlSignIn = '/users/sign_in.json';
  final String _urlSignUp = '/users.json';

  Future<http.Response> login(String email, String password) async {
    try {
      final response = await http.post(Uri.https(_url, _urlSignIn),
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
      rethrow;
    }
  }

  // Future<User?> registerUser(String email, String password,
  //     String passwordConfirmation, String name, String lastName) async {
  //   try {
  //     final response = await http.post(Uri.https(_url, _urlSignUp),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(<String, dynamic>{
  //           'user': {
  //             'email': email,
  //             'name': name,
  //             'lastname': lastName,
  //             'password': password,
  //             'password_confirmation': passwordConfirmation
  //           }
  //         }));
  //     if (response.statusCode == 201) {
  //       _user = User.fromJson(response.headers, jsonDecode(response.body));
  //       _authorizationStatus = AuthorizationStatus.authorized;
  //       return user;
  //     } else {
  //       _authorizationStatus = AuthorizationStatus.unauthorized;
  //       return user;
  //     }
  //   } catch (e) {
  //     _authorizationStatus = AuthorizationStatus.unauthorized;
  //     return user;
  //   }
  // }
}

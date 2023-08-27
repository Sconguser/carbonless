import 'dart:convert';

import 'package:carbonless/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'request_provider.dart';
import 'url_provider.dart';

enum RequestType { GET, POST, PATCH, UPDATE, DELETE, PUT }

class HttpService {
  HttpService(this.ref) : super();
  final Ref ref;
  Future<http.Response> executeHttp(
    RequestType requestType,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Endpoint endpoint,
  ) async {
    String? authorization = _getToken();
    if (authorization == null) {
      throw Exception('Did not find bearer token');
    }
    try {
      Uri resolvedUrl = Uri.https(url, endpoint.toEndpoint(), queryParameters);
      final response =
          await _execute(resolvedUrl, authorization, requestType, body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception(endpoint.toError());
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<http.Response> _execute(Uri url, String? authorization,
      RequestType requestType, Map<String, dynamic>? body) async {
    switch (requestType) {
      case RequestType.GET:
        return _httpGet(authorization, url);
      case RequestType.POST:
        return _httpPost(authorization, url, body);
      case RequestType.PATCH:
        return _httpPatch(authorization, url, body);
      case RequestType.UPDATE:
        return _httpUpdate(authorization, url, body);
      case RequestType.DELETE:
        return _httpDelete(authorization, url, body);
      case RequestType.PUT:
        return _httpPut(authorization, url, body);
    }
  }

  String? _getToken() {
    String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
    if (bearerToken != null) {
      return bearerToken;
    }
    return null;
  }

  Future<http.Response> _httpGet(String? authorization, Uri url) {
    Map<String, String> headers = _createHeaders(authorization);
    return http.get(url, headers: headers);
  }

  Future<http.Response> _httpPost(
      String? authorization, Uri url, Map<String, dynamic>? body) {
    Map<String, String> headers = _createHeaders(authorization);
    return http.post(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> _httpDelete(
      String? authorization, Uri url, Map<String, dynamic>? body) {
    Map<String, String> headers = _createHeaders(authorization);
    return http.delete(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> _httpUpdate(
      String? authorization, Uri url, Map<String, dynamic>? body) {
    Map<String, String> headers = _createHeaders(authorization);
    return http.delete(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> _httpPatch(
      String? authorization, Uri url, Map<String, dynamic>? body) {
    Map<String, String> headers = _createHeaders(authorization);
    return http.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Future<http.Response> _httpPut(
      String? authorization, Uri url, Map<String, dynamic>? body) {
    Map<String, String> headers = _createHeaders(authorization);
    return http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  Map<String, String> _createHeaders(String? authorization) {
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/json; charset=UTF-8';
    if (authorization != null) {
      headers['Authorization'] = authorization;
    }
    return headers;
  }
}

final httpServiceProvider = Provider<HttpService>((ref) => HttpService(ref));

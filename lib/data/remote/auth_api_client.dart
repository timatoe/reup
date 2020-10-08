import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:reup/utils/constants.dart';

class AuthApiClient {
  static const authBaseUrl = "$baseUrl/auth";
  final http.Client httpClient;

  AuthApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<String> logIn(
    String email,
    String password,
  ) async {
    final loginUrl = '$authBaseUrl/login';
    var loginResponse = await this
        .httpClient
        .post(loginUrl, body: {"email": email, "password": password});
    if (loginResponse.statusCode != HttpStatus.ok) {
      throw Exception('error logging in');
    }
    return loginResponse.body;
  }
}

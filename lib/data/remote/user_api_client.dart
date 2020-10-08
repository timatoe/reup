import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:reup/data/models/user.dart';
import 'package:reup/utils/constants.dart';
import 'package:reup/utils/platform_aware_secure_storage.dart';

class UserApiClient {
  static const userBaseUrl = "$baseUrl/user";
  final http.Client httpClient;
  final PlatformAwareSecureStorage secureStorage;

  UserApiClient({@required this.httpClient, @required this.secureStorage})
      : assert(
          httpClient != null,
          secureStorage != null,
        );

  Future<User> getUser() async {
    final jwt = await secureStorage.read(key: "jwt");
    if (jwt == null) {
      throw Exception('jwt is missing');
    }
    final userUrl = '$userBaseUrl/user';
    var userResponse = await this.httpClient.get(
      userUrl, 
      headers: {
      "Authorization": "Bearer $jwt"
      }
    );
    if (userResponse.statusCode != HttpStatus.ok) {
      throw Exception('error getting user');
    }
    return User.fromJson(jsonDecode(userResponse.body));
  }
}

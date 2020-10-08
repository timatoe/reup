import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reup/data/remote/auth_api_client.dart';
import 'package:reup/data/remote/user_api_client.dart';
import 'package:reup/utils/platform_aware_secure_storage.dart';
import 'package:reup/utils/simple_bloc_observer.dart';

import 'app.dart';
import 'data/authentication_repository.dart';
import 'data/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' show window;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final mobileSecureStorage = FlutterSecureStorage();
  
  final secureStorage = PlatformAwareSecureStorage(
    mobileSecureStorage, 
    window.localStorage
  );

  runApp(App(
    authenticationRepository: AuthenticationRepository(
      AuthApiClient(httpClient: http.Client()),
      secureStorage,
    ),
    userRepository: UserRepository(
        UserApiClient(httpClient: http.Client(), secureStorage: secureStorage)),
  ));
}

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:reup/data/remote/auth_api_client.dart';
import 'package:reup/utils/platform_aware_secure_storage.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final AuthApiClient authApiClient;
  final PlatformAwareSecureStorage secureStorage;

  AuthenticationRepository(this.authApiClient, this.secureStorage)
      : assert(authApiClient != null, secureStorage != null);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    var jwt = await secureStorage.read(key: "jwt");
    yield jwt == null
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);
    try {
      var jwt = await authApiClient.logIn(email, password);
      await secureStorage.write(key: "jwt", value: jwt);
      _controller.add(AuthenticationStatus.authenticated);
    } on Exception catch (exception) {
      print(exception);
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> logOut() async {
    await secureStorage.delete(key: "jwt");
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

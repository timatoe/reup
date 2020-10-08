import 'package:reup/data/remote/user_api_client.dart';

import 'models/user.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository(this.userApiClient) : assert(userApiClient != null);

  Future<User> getUser() async {
    return userApiClient.getUser();
  }
}

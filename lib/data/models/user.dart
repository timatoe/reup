import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String displayName;

  User(this.id, this.email, this.displayName);

  @override
  List<Object> get props => [
        id,
        email,
        displayName,
      ];

  static User fromJson(dynamic json) {
    return User(
      json['userId'] as int,
      json['email'],
      json['displayName'],
    );
  }
}

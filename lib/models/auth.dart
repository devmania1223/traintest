import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final int id;
  final String email;
  final String username;

  const Auth({this.id, this.email, this.username, this.token});

  @override
  List<Object> get props => [
        token,
        id,
        email,
        username,
      ];

  static Auth fromJson(dynamic json) {
    final authData = json['data'];
    return Auth(
      token: authData['token'] as String,
      id: authData['user_id'] as int,
      email: authData['user_email'] as String,
      username: authData['user_name'] as String,
    );
  }
}

// ignore_for_file: public_member_api_docs

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:logger/logger.dart';
import 'package:server/models/user.dart';

import 'package:server/db/sql_client.dart';

class UserRepository {
  // singleton
  factory UserRepository() {
    return _instance;
  }
  UserRepository._privateConstructor(
    this.sqlClient,
  );

  SqlClient sqlClient;

  static final UserRepository _instance = UserRepository._privateConstructor(
    SqlClient(),
  );

  Future<User?> getUser(String token) async {
    final payload = JWT.verify(
      token,
      SecretKey('123'),
    );

    final payloadData = payload.payload as Map<String, dynamic>;

    final email = payloadData['email'] as String;
    final result = await sqlClient.execute(
      'SELECT * FROM users WHERE email = :email',
      params: {
        'email': email,
      },
    );

    if (result.rows.isEmpty) return null;

    return User.fromAssoc(
      result.rows.first.assoc(),
    );
  }
}

User? verifyToken(String token) {
  try {
    final payload = JWT.verify(
      token,
      SecretKey('123'),
    );

    final payloadData = payload.payload as Map<String, dynamic>;

    final username = payloadData['username'] as String;
    return User(
      email: username,
      password: 'f',
      name: 'f',
      image: 'f',
    );
  } catch (e) {
    return null;
  }
}

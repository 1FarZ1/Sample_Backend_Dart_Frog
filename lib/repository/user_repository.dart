// ignore_for_file: public_member_api_docs
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:server/db/sql_client.dart';
import 'package:server/models/user.dart';

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

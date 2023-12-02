// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:server/db/sql_client.dart';

import 'package:server/models/user.dart';

class AuthRepository {
  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._privateConstructor({
    SqlClient? sqlClient,
  }) : sqlClient = sqlClient ?? SqlClient();

  SqlClient sqlClient;

  static final AuthRepository _instance = AuthRepository._privateConstructor(
    sqlClient: SqlClient(),
  );

  Future<User?> login(String email, String password) async {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);

    final result = await sqlClient.execute(
      'SELECT * FROM users WHERE email = :email AND password = :password',
      params: {
        'email': email,
        'password': digest.toString(),
      },
    );

    //

    if (result.rows.isEmpty) return null;

    return User.fromAssoc(
      result.rows.first.assoc(),
    );
  }

  Future<bool> register(
    String email,
    String password,
    String name, {
    String? image,
  }) async {
    final isUserExist = await sqlClient.execute(
      'SELECT * FROM users WHERE email = :email',
      params: {
        'email': email,
      },
    );

    if (isUserExist.rows.isNotEmpty) return false;

    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);

    final result = await sqlClient.execute(
      'INSERT INTO users (email, password, name, image) VALUES (:email, :password, :name, :image)',
      params: {
        'email': email,
        'password': digest.toString(),
        'name': name,
        'image': image,
      },
    );

    if (result.rows.isEmpty) return false;
    
    
    return true;
  }
}

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
    // convert password
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
    // check if user exists
    final isUserExist = await sqlClient.execute(
      'SELECT * FROM users WHERE email = :email',
      params: {
        'email': email,
      },
    );

    // print('isUserExist: ${isUserExist.numOfRows}');
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
    
    return true;
  }
}

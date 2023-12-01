// do singleton and add 1 methode for login and 1 for register only

// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:server/repository/sql_client.dart';

import 'package:server/models/user.dart';

// final _users = [
//   User(email: 'f_bekkouche@estin.dz', password: 'mrfares77'),
//   User(email: 'f_bekkouche1@estin.dz', password: 'mrfares77'),
//   User(email: 'f_bekkouche2@estin.dz', password: 'mrfares77'),
//   User(email: 'f_bekkouche3@estin.dz', password: 'mrfares77'),
//   User(email: 'f_bekkouche4@estin.dz', password: 'mrfares77'),
//   User(email: 'f_bekkouche5@estin.dz', password: 'mrfares77'),
// ];

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
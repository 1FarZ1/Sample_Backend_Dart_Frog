// do singleton and add 1 methode for login and 1 for register only

// ignore_for_file: public_member_api_docs

import 'package:server/repository/sql_client.dart';

class User {
  User({required this.email, required this.password});

  User.fromAssoc(Map<String, dynamic> assoc)
      : email = assoc['email'] as String,
        password = assoc['password'] as String;

  // constructor from json
  User.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        password = json['password'] as String;
  String email;
  String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  Map<String, dynamic> toAssoc() => {
        'email': email,
        'password': password,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}

class AuthRepository {
  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._privateConstructor({
    SqlClient? sqlClient,
  }) : sqlClient = sqlClient ?? SqlClient();

  SqlClient sqlClient;

  final _users = [
    User(email: 'f_bekkouche@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche1@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche2@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche3@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche4@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche5@estin.dz', password: 'mrfares77'),
  ];
  static final AuthRepository _instance = AuthRepository._privateConstructor(
    sqlClient: SqlClient(),
  );
  Future<String?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return null;

    final result = await sqlClient.execute(
      'SELECT * FROM users WHERE email = :email AND password = :password',
      params: {
        'email': email,
        'password': password,
      },
    );
    if (result.rows.isEmpty) return null;


    return 'token';
  }

  Future<bool> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;
    _users.add(User(email: email, password: password));
    return true;
  }
}
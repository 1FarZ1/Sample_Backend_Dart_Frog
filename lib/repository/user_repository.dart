// ignore_for_file: public_member_api_docs

import 'package:server/models/user.dart';

class UserRepository {
  // singleton
  factory UserRepository() {
    return _instance;
  }
  UserRepository._privateConstructor();

  static final UserRepository _instance = UserRepository._privateConstructor();

  Future<User> getUser() async {
    return User(
      email: 'f',
      password: 'bek',
      name: 'f',
      image: 'f',
    );
  }
}

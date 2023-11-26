// do singleton and add 1 methode for login and 1 for register only

// ignore_for_file: public_member_api_docs

class User {
  User({required this.email, required this.password});

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
  AuthRepository._privateConstructor();
  final _users = [
    User(email: 'f_bekkouche@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche1@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche2@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche3@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche4@estin.dz', password: 'mrfares77'),
    User(email: 'f_bekkouche5@estin.dz', password: 'mrfares77'),
  ];
  static final AuthRepository _instance = AuthRepository._privateConstructor();
  Future<String?> login(String email, String password) async {
    print('login: email: $email, password: $password, users: ${_users.length}');
    if (email == 'f_bekkouche@estin.dz' && password == 'mrfares77')
      return 'some token';

    if (_users.contains(User(email: email, password: password))) {
      return 'some token';
    }
    return null;
  }

  Future<bool> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;
    _users.add(User(email: email, password: password));
    return true;
  }
}

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

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is User && other.email == email && other.password == password;
  // }

  // @override
  // int get hashCode => email.hashCode ^ password.hashCode;
}
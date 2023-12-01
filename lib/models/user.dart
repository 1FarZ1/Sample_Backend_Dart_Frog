// ignore_for_file: public_member_api_docs

class User {
  User({
    required this.email,
    required this.password,
    required this.name,
    this.image,
  });

  // constructor from json
  User.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        password = json['password'] as String,
        name = json['name'] as String,
        image = json['image'] as String?;

  // constructor from Assoc
  User.fromAssoc(Map<String, dynamic> assoc)
      : email = assoc['email'] as String,
        password = assoc['password'] as String,
        name = assoc['name'] as String,
        image = assoc['image'] as String?;
  String email;
  String password;
  String name;
  String? image;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'image': image,
      };
}

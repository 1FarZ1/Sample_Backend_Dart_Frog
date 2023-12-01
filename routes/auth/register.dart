import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/authRepository.dart';

import 'login.dart';

class SignUpBody {
  SignUpBody({
    required this.email,
    required this.password,
    required this.name,
    this.image,
  });

  // constructor from json
  SignUpBody.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        password = json['password'] as String,
        name = json['name'] as String,
        image = json['image'] as String?;
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

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(body: 'This is a Register route!');
  }

  final authRepo = context.read<AuthRepository>();
  final body = await context.request.json() as Map<String, dynamic>;
  final signUpBody = SignUpBody.fromJson(body);
  if (signUpBody.email.isEmpty ||
      signUpBody.password.isEmpty ||
      signUpBody.name.isEmpty) {
    return Response(body: 'Please Provide All fields', statusCode: 401);
  }

  final isRegistered = await authRepo.register(
    signUpBody.email,
    signUpBody.password,
    signUpBody.name,
    image: signUpBody.image ?? '',
  );
  if (!isRegistered) {
    return Response(body: 'Invalid credentials', statusCode: 401);
  }

  // login user
  final token = await authRepo.login(signUpBody.email, signUpBody.password);
  return Response.json(
    body: {
      'message': 'User Registered successfully',
      'status': 201,
      'token': token,
    },
  );
}

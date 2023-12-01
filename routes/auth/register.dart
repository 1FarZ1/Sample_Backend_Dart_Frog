import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/auth_repository.dart';
import './login.dart';

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
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _onPost(
  RequestContext context,
) async {
  final authRepo = context.read<AuthRepository>();
  final body = await context.request.json() as Map<String, dynamic>;
  final signUpBody = SignUpBody.fromJson(body);
  if (signUpBody.email.isEmpty ||
      signUpBody.password.isEmpty ||
      signUpBody.name.isEmpty) {
    return Response(
      body: 'Please Provide All fields',
      statusCode: HttpStatus.badRequest,
    );
  }

  final isRegistered = await authRepo.register(
    signUpBody.email,
    signUpBody.password,
    signUpBody.name,
    image: signUpBody.image ?? '',
  );
  // print isRegistered;
  print('isRegistered: $isRegistered');
  if (!isRegistered) {
    return Response(
      body: 'User already exists',
      statusCode: HttpStatus.badRequest,
    );
  }

  final user = await authRepo.login(signUpBody.email, signUpBody.password);
  if (user == null) {
    return Response(
      body: 'Invalid credentials',
      statusCode: HttpStatus.badRequest,
    );
  }
  final token = generateToken(
    username: signUpBody.email,
    user: user,
  );

  return Response.json(
    body: {
      'message': 'User Registered successfully',
      'status': HttpStatus.created,
      'token': token,
    },
  );
}

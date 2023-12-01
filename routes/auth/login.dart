import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:server/models/user.dart';
import 'package:server/repository/auth_repository.dart';

class SignInBody {
  SignInBody({required this.email, required this.password});

  // constructor from json
  SignInBody.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        password = json['password'] as String;
  String email;
  String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
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
  final signInBody = SignInBody.fromJson(body);
  if (signInBody.email.isEmpty || signInBody.password.isEmpty) {
    return Response(
      body: 'Please Provide All fields',
      statusCode: HttpStatus.badRequest,
    );
  }

  final user = await authRepo.login(signInBody.email, signInBody.password);
  if (user == null) {
    return Response(
      body: 'Invalid credentials',
      statusCode: HttpStatus.badRequest,
    );
  }

  final token = generateToken(
    username: signInBody.email,
    user: user,
  );

  return Response.json(
    body: {
      'message': 'User Logged in successfully',
      'status': HttpStatus.ok,
      'token': token,
    },
  );
}

String generateToken({
  required String username,
  required User user,
}) {
  final jwt = JWT(
    {
      'email': user.email,
      'name': user.name,
      'username': username,
    },
  );

  return jwt.sign(SecretKey('123'));
}

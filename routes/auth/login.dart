import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/authRepository.dart';

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

  final token = await authRepo.login(signInBody.email, signInBody.password);
  if (token == null) {
    return Response(
      body: 'Invalid credentials',
      statusCode: HttpStatus.badRequest,
    );
  }

  return Response.json(
    body: {
      'message': 'User Logged in successfully',
      'status': 201,
      'token': token,
    },
  );
}

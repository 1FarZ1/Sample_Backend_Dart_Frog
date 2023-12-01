import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/authRepository.dart';

import 'login.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(body: 'This is a Register route!');
  }

  final authRepo = context.read<AuthRepository>();
  final body = await context.request.json() as Map<String, dynamic>;
  final signInBody = SignInBody.fromJson(body);

  final isRegistered =
      await authRepo.register(signInBody.email, signInBody.password);
  if (!isRegistered) {
    return Response(body: 'Invalid credentials', statusCode: 401);
  }

  // login user
  final token = await authRepo.login(signInBody.email, signInBody.password);
  return Response.json(body: token);
}

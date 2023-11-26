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
  if (context.request.method != HttpMethod.post) {
    return Response(body: 'This is a Login route!');
  }

  final authRepo = context.read<AuthRepository>();

  final body = await context.request.json() as Map<String, dynamic>;

  final signInBody = SignInBody.fromJson(body);

  final token = await authRepo.login(signInBody.email, signInBody.password);
  if (token == null) {
    return Response(body: 'Invalid credentials', statusCode: 401);
  }

  return Response.json(body: token);

  // return Response.json(body: SignInBody.fromJson(body));
  // return Response(body: 'This is a Login route!');
}

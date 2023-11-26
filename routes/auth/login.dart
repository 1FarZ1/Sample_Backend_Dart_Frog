import 'package:dart_frog/dart_frog.dart';

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
  // if reequest not post return
  if (context.request.method != HttpMethod.post) {
    return Response(body: 'This is a Login route!');
  }

  // get body from request
  final body = await context.request.json() as Map<String, dynamic>;
  return Response.json(body: SignInBody.fromJson(body));
  // return Response(body: 'This is a Login route!');
}

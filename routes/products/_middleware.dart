import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:server/models/user.dart';

import 'package:server/repository/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      authenticator: (context, token) async {
        print("token");
        return context.read<UserRepository>().getUser();
      },
    ),

  );

  // return handler;
}

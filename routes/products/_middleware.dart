import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:server/models/user.dart';
import 'package:server/repository/product_repository.dart';
import 'package:server/repository/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      authenticator: (context, token) async {
        return context.read<UserRepository>().getUser(token);
      },
    ),
  ).use(provider((context) => ProductRepository()));

  // return handler;
}

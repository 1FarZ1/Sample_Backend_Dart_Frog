import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<UserRepository>(
      (_) => UserRepository(),
    ),
  );
}

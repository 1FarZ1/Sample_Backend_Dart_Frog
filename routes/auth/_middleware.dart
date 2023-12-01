import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/auth_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<AuthRepository>((context) => AuthRepository()));
}

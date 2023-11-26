import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository/authRepository.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<AuthRepository>((context) => AuthRepository()));
}

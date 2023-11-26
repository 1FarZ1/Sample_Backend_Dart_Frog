import 'package:dart_frog/dart_frog.dart';

import '../../repository/productRepository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<ProductRepository>(
      (context) => ProductRepository(),
    ),
  );
  // return handler;
}

  // return DatabaseClient(
      //   // dbUrl: Platform.environment['DB_URL'],
      //   // dbUser: Platform.environment['DB_USER'],
      //   // dbPassword: Platform.environment['DB_PASSWORD'],
      // );

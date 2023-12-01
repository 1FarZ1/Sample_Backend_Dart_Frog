import 'package:dart_frog/dart_frog.dart';

import 'package:server/repository/productRepository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<ProductRepository>(
      (context) => ProductRepository(),
    ),
  );
  // return handler;
}

import 'package:dart_frog/dart_frog.dart';

import '../../repository/productRepository.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final products = await context.read<ProductRepository>().fetchProducts();
    return Response.json(
      body: products,
    );
  } catch (e) {
    return Response(
      statusCode: 500,
      body: e.toString(),
    );
  }
}

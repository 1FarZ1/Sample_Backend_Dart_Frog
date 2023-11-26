import 'package:dart_frog/dart_frog.dart';

import '../../../server/models/product.dart';
import '../../../server/repository/productRepository.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    default:
      return Response(
        statusCode: 405,
        body: 'Method not allowed',
      );
  }
}

Future<Response> _get(RequestContext context) async {
  final products = await context.read<ProductRepository>().fetchProducts(
        page: int.tryParse(context.request.uri.queryParameters['page'] ?? '0'),
        limit:
            int.tryParse(context.request.uri.queryParameters['limit'] ?? '2'),
        search: context.request.uri.queryParameters['search'],
      );
  return Response.json(
    body: products,
  );
}

Future<Response> _post(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final product = await context
      .read<ProductRepository>()
      .createProduct(Product.fromJson(body));

  return Response.json(
    body: {
      'message': 'Product created successfully',
      'product': product,
    },
  );
}

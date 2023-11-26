import 'package:dart_frog/dart_frog.dart';

import '../../../server/models/product.dart';
import '../../../server/repository/productRepository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, id);
    case HttpMethod.put:
      return _put(context, id);
    case HttpMethod.delete:
      return _delete(context, id);
    default:
      return Response(
        statusCode: 405,
        body: 'Method not allowed',
      );
  }
}

Future<Response> _get(RequestContext context, String id) async {
  final product =
      await context.read<ProductRepository>().fetchProductById(int.parse(id));
  if (product == null) {
    return Response(
      statusCode: 404,
      body: 'Product not found',
    );
  }
  return Response.json(
    body: product,
  );
}

Future<Response> _put(RequestContext context, String id) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final product = await context
      .read<ProductRepository>()
      .updateProduct(Product.fromJson(body));
  if (product == null) {
    return Response(
      statusCode: 404,
      body: 'Product not found',
    );
  }
  return Response.json(
    body: {
      'message': 'Product updated successfully',
      'product': product,
    },
  );
}

Future<Response> _delete(RequestContext context, String id) async {
  final result =
      await context.read<ProductRepository>().deleteProduct(int.parse(id));
  if (!result) {
    return Response(
      statusCode: 404,
      body: 'Product not found',
    );
  }
  return Response.json(
    body: {
      'message': 'Product deleted successfully',
    },
  );
}

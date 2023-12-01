import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:server/models/product.dart';
import 'package:server/repository/productRepository.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _get(context),
    HttpMethod.post => _post(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _get(RequestContext context) async {
  final products = await context.read<ProductRepository>().fetchProducts(
        page: int.tryParse(context.request.uri.queryParameters['page'] ?? '0'),
        limit:
            int.tryParse(context.request.uri.queryParameters['limit'] ?? '2'),
        search: context.request.uri.queryParameters['search'],
      );
  return Response.json(
    body: {
      'message': 'Products fetched successfully',
      'status': HttpStatus.ok,
      'products': products,
    },
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
      'status': HttpStatus.created,
    },
  );
}

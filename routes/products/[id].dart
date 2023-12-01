import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import 'package:server/models/product.dart';
import 'package:server/repository/productRepository.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  return switch (context.request.method) {
    HttpMethod.get => _get(context, id),
    HttpMethod.put => _put(context, id),
    HttpMethod.delete => _delete(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
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

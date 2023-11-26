import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async  {
  final request = context.request;

  // final method = request.method.value;
  final params = request.uri.queryParameters;

  // final name = params['name'] ?? 'Kho';
  final body =  await request.body();

  return Response.json(
    body: {
      'method': request.method.value,
      'params': params,
      'body': body,
    },
  );
}

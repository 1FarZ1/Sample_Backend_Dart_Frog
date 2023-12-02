import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(
    body: {
      'error': 'Method not allowed',
      'status': HttpStatus.methodNotAllowed,
    },
  );
}

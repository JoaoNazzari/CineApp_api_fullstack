import 'package:shelf/shelf.dart';

/// Middleware de logging
Middleware logMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      final stopwatch = Stopwatch()..start();
      final response = await innerHandler(request);
      stopwatch.stop();

      print(
        '${request.method.padRight(6)} '
        '${request.requestedUri.path} '
        '→ ${response.statusCode} '
        '(${stopwatch.elapsedMilliseconds}ms)',
      );

      return response;
    };
  };
}

/// Middleware de CORS
Middleware corsMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      final corsHeaders = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      };

      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: corsHeaders);
      }

      final response = await innerHandler(request);
      return response.change(headers: corsHeaders);
    };
  };
}

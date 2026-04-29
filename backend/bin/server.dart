import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:apidart/database/filmes_database.dart';
import 'package:apidart/database/atores_database.dart';
import 'package:apidart/middlewares/middleware.dart';
import 'package:apidart/routes/filmes_router.dart';
import 'package:apidart/routes/atores_router.dart';

void main() async {
  final filmeDb = FilmesDatabaseHelper();
  await filmeDb.initialize();
  print('✅ Tabela filmes inicializada');

  final atorDb = AtoresDatabaseHelper();
  await atorDb.initialize();
  print('✅ Tabela atores inicializada');

  final cascade = Cascade()
      .add(atorRouter(atorDb, filmeDb).call)
      .add(filmeRouter(filmeDb).call);

  final handler = Pipeline()
      .addMiddleware(logMiddleware())
      .addMiddleware(corsMiddleware())
      .addHandler(cascade.handler);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor rodando em http://localhost:${server.port}');
  print('📋 Endpoints disponíveis:');
  print('   --- Filmes (pai) ---');
  print('   GET    /filmes');
  print('   GET    /filmes/<id>');
  print('   POST   /filmes');
  print('   POST   /filmes/lote');
  print('   PUT    /filmes/<id>');
  print('   PUT    /filmes/lote');
  print('   DELETE /filmes/<id>');
  print('   --- Atores (filho) ---');
  print('   GET    /atores');
  print('   GET    /atores/<id>');
  print('   GET    /filmes/<id>/atores');
  print('   POST   /atores');
  print('   POST   /atores/lote');
  print('   PUT    /atores/<id>');
  print('   DELETE /atores/<id>');
}

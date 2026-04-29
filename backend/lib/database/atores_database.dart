import 'dart:io';
import 'package:postgres/postgres.dart';
import '../models/atores.dart';

class AtoresDatabaseHelper {
  late Connection _db;

  Future<void> initialize() async {
    final envFile = File(Platform.script.resolve('../.env').toFilePath());
    final connectionString = (await envFile.readAsString()).trim();
    final uri = Uri.parse(connectionString);

    _db = await Connection.open(
      Endpoint(
        host: uri.host,
        port: uri.hasPort ? uri.port : 5432,
        database: uri.pathSegments.first,
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.split(':').last,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );

    await _db.execute('''
      CREATE TABLE IF NOT EXISTS atores (
        id          SERIAL PRIMARY KEY,
        nome        TEXT    NOT NULL,
        personagem  TEXT    NOT NULL,
        idade       INTEGER NOT NULL,
        "filmeId"   INTEGER NOT NULL
          REFERENCES filmes(id) ON DELETE CASCADE
      );
    ''');
  }

  Ator _fromRow(ResultRow row) {
    final m = row.toColumnMap();
    return Ator(
      id: m['id'] as int,
      nome: m['nome'] as String,
      personagem: m['personagem'] as String,
      idade: m['idade'] as int,
      filmeId: m['filmeId'] as int,
    );
  }

  Future<List<Ator>> getAll() async {
    final result = await _db.execute(
      Sql.named('SELECT * FROM atores ORDER BY id DESC'),
    );
    return result.map(_fromRow).toList();
  }

  Future<Ator?> getById(int id) async {
    final result = await _db.execute(
      Sql.named('SELECT * FROM atores WHERE id = @id'),
      parameters: {'id': id},
    );
    if (result.isEmpty) return null;
    return _fromRow(result.first);
  }

  Future<List<Ator>> getByFilmeId(int filmeId) async {
    final result = await _db.execute(
      Sql.named(
        'SELECT * FROM atores WHERE "filmeId" = @filmeId ORDER BY id DESC',
      ),
      parameters: {'filmeId': filmeId},
    );
    return result.map(_fromRow).toList();
  }

  Future<Ator> insert(Ator ator) async {
    final result = await _db.execute(
      Sql.named('''
        INSERT INTO atores (nome, personagem, idade, "filmeId")
        VALUES (@nome, @personagem, @idade, @filmeId)
        RETURNING *
      '''),
      parameters: {
        'nome': ator.nome,
        'personagem': ator.personagem,
        'idade': ator.idade,
        'filmeId': ator.filmeId,
      },
    );
    return _fromRow(result.first);
  }

  Future<Ator?> update(int id, Ator ator) async {
    final result = await _db.execute(
      Sql.named('''
        UPDATE atores
        SET nome       = @nome,
            personagem = @personagem,
            idade      = @idade,
            "filmeId"  = @filmeId
        WHERE id = @id
        RETURNING *
      '''),
      parameters: {
        'id': id,
        'nome': ator.nome,
        'personagem': ator.personagem,
        'idade': ator.idade,
        'filmeId': ator.filmeId,
      },
    );
    if (result.isEmpty) return null;
    return _fromRow(result.first);
  }

  Future<bool> delete(int id) async {
    final result = await _db.execute(
      Sql.named('DELETE FROM atores WHERE id = @id RETURNING id'),
      parameters: {'id': id},
    );
    return result.isNotEmpty;
  }

  Future<void> close() async => await _db.close();
}

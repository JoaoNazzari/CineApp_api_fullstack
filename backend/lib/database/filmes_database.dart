import 'dart:io';
import 'package:postgres/postgres.dart';
import '../models/filmes.dart';

class FilmesDatabaseHelper {
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
      CREATE TABLE IF NOT EXISTS filmes (
        id            SERIAL PRIMARY KEY,
        titulo        TEXT    NOT NULL,
        genero        TEXT    NOT NULL,
        duracao       TEXT    NOT NULL,
        "faixaEtaria" INTEGER NOT NULL DEFAULT 0,
        "imagemUrl"   TEXT
      );
    ''');

    await _db.execute('''
      ALTER TABLE filmes ADD COLUMN IF NOT EXISTS "imagemUrl" TEXT;
    ''');
  }

  Filme _fromRow(ResultRow row) {
    final m = row.toColumnMap();
    return Filme(
      id: m['id'] as int,
      titulo: m['titulo'] as String,
      genero: m['genero'] as String,
      duracao: m['duracao'] as String,
      faixaEtaria: m['faixaEtaria'] as int,
      imagemUrl: m['imagemUrl'] as String?,
    );
  }

  Future<List<Filme>> getAll() async {
    final result = await _db.execute(
      Sql.named('SELECT * FROM filmes ORDER BY id DESC'),
    );
    return result.map(_fromRow).toList();
  }

  Future<List<Filme>> getByAgeAndGenre(int idade, String genero) async {
    final result = await _db.execute(
      Sql.named(
        'SELECT * FROM filmes WHERE "faixaEtaria" <= @idade AND genero = @genero ORDER BY id DESC',
      ),
      parameters: {'idade': idade, 'genero': genero},
    );
    return result.map(_fromRow).toList();
  }

  Future<List<Filme>> getAllowedByAge(int idadeUsuario) async {
    final result = await _db.execute(
      Sql.named(
        'SELECT * FROM filmes WHERE "faixaEtaria" <= @idade ORDER BY "faixaEtaria" DESC',
      ),
      parameters: {'idade': idadeUsuario},
    );
    return result.map(_fromRow).toList();
  }

  Future<List<Filme>> getByGenre(String genero) async {
    final result = await _db.execute(
      Sql.named('SELECT * FROM filmes WHERE genero = @genero ORDER BY id DESC'),
      parameters: {'genero': genero},
    );
    return result.map(_fromRow).toList();
  }

  Future<Filme?> getById(int id) async {
    final result = await _db.execute(
      Sql.named('SELECT * FROM filmes WHERE id = @id'),
      parameters: {'id': id},
    );
    if (result.isEmpty) return null;
    return _fromRow(result.first);
  }

  Future<Filme> insert(Filme filme) async {
    final result = await _db.execute(
      Sql.named('''
        INSERT INTO filmes (titulo, genero, duracao, "faixaEtaria", "imagemUrl")
        VALUES (@titulo, @genero, @duracao, @faixaEtaria, @imagemUrl)
        RETURNING *
      '''),
      parameters: {
        'titulo': filme.titulo,
        'genero': filme.genero,
        'duracao': filme.duracao,
        'faixaEtaria': filme.faixaEtaria,
        'imagemUrl': filme.imagemUrl,
      },
    );
    return _fromRow(result.first);
  }

  Future<Filme?> update(int id, Filme filme) async {
    final result = await _db.execute(
      Sql.named('''
        UPDATE filmes
        SET titulo = @titulo,
            genero = @genero,
            duracao = @duracao,
            "faixaEtaria" = @faixaEtaria,
            "imagemUrl" = @imagemUrl
        WHERE id = @id
        RETURNING *
      '''),
      parameters: {
        'id': id,
        'titulo': filme.titulo,
        'genero': filme.genero,
        'duracao': filme.duracao,
        'faixaEtaria': filme.faixaEtaria,
        'imagemUrl': filme.imagemUrl,
      },
    );
    if (result.isEmpty) return null;
    return _fromRow(result.first);
  }

  Future<bool> delete(int id) async {
    final result = await _db.execute(
      Sql.named('DELETE FROM filmes WHERE id = @id RETURNING id'),
      parameters: {'id': id},
    );
    return result.isNotEmpty;
  }

  Future<void> close() async => await _db.close();
}

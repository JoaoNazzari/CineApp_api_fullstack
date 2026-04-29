import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../models/filme.dart';
import '../models/ator.dart';

class ApiService {
  // No Chrome usa localhost, no emulador Android usa 10.0.2.2
  static String get baseUrl =>
      kIsWeb ? 'http://localhost:8080' : 'http://10.0.2.2:8080';

  // GET /filmes — lista todos os filmes
  Future<List<Filme>> listarFilmes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/filmes'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Filme.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar filmes (status ${response.statusCode})');
    }
  }

  // GET /filmes/:id — busca um filme
  Future<Filme> buscarFilme(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filmes/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Filme.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Filme não encontrado');
    } else {
      throw Exception('Erro ao buscar filme (status ${response.statusCode})');
    }
  }

  // GET /filmes/:id/atores — lista atores de um filme
  Future<List<Ator>> listarAtoresPorFilme(int filmeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filmes/$filmeId/atores'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Ator.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Filme não encontrado');
    } else {
      throw Exception('Erro ao carregar atores (status ${response.statusCode})');
    }
  }

  // GET /atores — lista todos os atores
  Future<List<Ator>> listarAtores() async {
    final response = await http.get(
      Uri.parse('$baseUrl/atores'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Ator.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar atores (status ${response.statusCode})');
    }
  }
}

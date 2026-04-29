import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../services/api_service.dart';
import 'filme_detalhe_screen.dart';

class FilmesListScreen extends StatefulWidget {
  const FilmesListScreen({super.key});

  @override
  State<FilmesListScreen> createState() => _FilmesListScreenState();
}

class _FilmesListScreenState extends State<FilmesListScreen> {
  List<Filme> _filmes = [];
  List<Filme> _filmesFiltrados = [];
  bool _carregando = true;
  String? _erro;

  final ApiService _api = ApiService();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      final filmes = await _api.listarFilmes();
      setState(() {
        _filmes = filmes;
        _filmesFiltrados = filmes;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _carregando = false;
      });
    }
  }

  void _filtrar(String texto) {
    setState(() {
      final termo = texto.toLowerCase();
      _filmesFiltrados = _filmes.where((f) {
        return f.titulo.toLowerCase().contains(termo) ||
            f.genero.toLowerCase().contains(termo) ||
            f.faixaEtaria.toString().contains(termo);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'CineApp',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE8A830),
                ),
              ),
            ),

            // Barra de busca
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: _filtrar,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Título, gênero, faixa etária...',
                  hintStyle: const TextStyle(color: Color(0xFF404048)),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF404048),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF161619),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF252530)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF252530)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8A830)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Corpo principal
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_carregando) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFE8A830)),
      );
    }

    if (_erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _erro!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _carregarDados,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filmesFiltrados.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum filme encontrado.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: _filmesFiltrados.length,
      itemBuilder: (context, index) {
        final filme = _filmesFiltrados[index];
        return _buildFilmeCard(filme);
      },
    );
  }

  Widget _buildFilmeCard(Filme filme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmeDetalheScreen(filme: filme),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF161619),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF222228), width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Área do poster (placeholder com gênero)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _corPorGenero(filme.genero),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: filme.imagemUrl != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          filme.imagemUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stack) => Center(
                            child: Text(
                              filme.genero.toUpperCase(),
                              style: const TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            filme.genero.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filme.titulo,
                    style: const TextStyle(
                      color: Color(0xFFD4D4D8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${filme.duracao} · ${filme.faixaEtaria}+',
                    style: const TextStyle(
                      color: Color(0xFF404048),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _corPorGenero(String genero) {
    switch (genero.toLowerCase()) {
      case 'acao':
      case 'ação':
        return const Color(0xFF1C0808);
      case 'terror':
        return const Color(0xFF0C0818);
      case 'drama':
        return const Color(0xFF100D08);
      case 'animacao':
      case 'animação':
        return const Color(0xFF0C1008);
      case 'comedia':
      case 'comédia':
        return const Color(0xFF0D100C);
      default:
        return const Color(0xFF08162A);
    }
  }
}

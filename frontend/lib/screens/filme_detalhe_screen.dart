import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../models/ator.dart';
import '../services/api_service.dart';

class FilmeDetalheScreen extends StatefulWidget {
  final Filme filme;

  const FilmeDetalheScreen({super.key, required this.filme});

  @override
  State<FilmeDetalheScreen> createState() => _FilmeDetalheScreenState();
}

class _FilmeDetalheScreenState extends State<FilmeDetalheScreen> {
  List<Ator> _atores = [];
  bool _carregandoAtores = true;
  String? _erroAtores;

  final ApiService _api = ApiService();

  @override
  void initState() {
    super.initState();
    _carregarAtores();
  }

  Future<void> _carregarAtores() async {
    setState(() {
      _carregandoAtores = true;
      _erroAtores = null;
    });

    try {
      final atores = await _api.listarAtoresPorFilme(widget.filme.id);
      setState(() {
        _atores = atores;
        _carregandoAtores = false;
      });
    } catch (e) {
      setState(() {
        _erroAtores = e.toString();
        _carregandoAtores = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filme = widget.filme;

    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão voltar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF161619),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF252530), width: 0.5),
                        ),
                        child: const Icon(Icons.chevron_left, color: Color(0xFFE8A830), size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text('Filmes', style: TextStyle(color: Color(0xFFE8A830), fontSize: 14)),
                    ],
                  ),
                ),
              ),

              // Banner com título
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                decoration: BoxDecoration(
                  color: _corPorGenero(filme.genero),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filme.titulo,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF0F0F4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      filme.genero,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF60606A)),
                    ),
                  ],
                ),
              ),

              // Pills de info
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _pill(filme.genero, const Color(0xFF0C1E30), const Color(0xFF378ADD)),
                    _pill(filme.duracao, const Color(0xFF1C1808), const Color(0xFFBA7517)),
                    _pill('${filme.faixaEtaria}+', const Color(0xFF1C0C08), const Color(0xFF993C1D)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Seção elenco
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Elenco',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFC4C4C8),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Lista de atores
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildAtores(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAtores() {
    if (_carregandoAtores) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator(color: Color(0xFFE8A830))),
      );
    }

    if (_erroAtores != null) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(_erroAtores!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (_atores.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Nenhum ator cadastrado para este filme.',
          style: TextStyle(color: Color(0xFF404048)),
        ),
      );
    }

    return Column(
      children: _atores.map((ator) => _buildAtorCard(ator)).toList(),
    );
  }

  Widget _buildAtorCard(Ator ator) {
    final iniciais = ator.nome.split(' ').map((p) => p[0]).take(2).join().toUpperCase();

    return GestureDetector(
      onTap: () {
        // TODO: navegar para detalhe do ator se quiser
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF161619),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF252530), width: 0.5),
        ),
        child: Row(
          children: [
            // Avatar com iniciais
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1A1A24),
                border: Border.all(color: const Color(0xFFE8A830), width: 1.5),
              ),
              child: Center(
                child: Text(
                  iniciais,
                  style: const TextStyle(
                    color: Color(0xFFE8A830),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Info do ator
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ator.nome,
                    style: const TextStyle(
                      color: Color(0xFFD4D4D8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${ator.personagem} · ${ator.idade} anos',
                    style: const TextStyle(
                      color: Color(0xFF404048),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Seta indicando clicável
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E1E24),
                border: Border.all(color: const Color(0xFF2E2E38), width: 0.5),
              ),
              child: const Icon(Icons.chevron_right, color: Color(0xFF505060), size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill(String texto, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500),
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
      default:
        return const Color(0xFF08162A);
    }
  }
}
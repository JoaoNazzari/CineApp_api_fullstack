import 'package:flutter/material.dart';
import '../models/ator.dart';
import '../services/api_service.dart';

class AtoresListScreen extends StatefulWidget {
  const AtoresListScreen({super.key});

  @override
  State<AtoresListScreen> createState() => _AtoresListScreenState();
}

class _AtoresListScreenState extends State<AtoresListScreen> {
  List<Ator> _atores = [];
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
      final atores = await _api.listarAtores();
      setState(() {
        _atores = atores;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _erro = e.toString();
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0C0F),
        title: const Text(
          'Atores',
          style: TextStyle(color: Color(0xFFE8A830), fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFE8A830)),
      ),
      body: _buildBody(),
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

    if (_atores.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum ator encontrado.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _atores.length,
      itemBuilder: (context, index) {
        final ator = _atores[index];
        final iniciais = ator.nome.split(' ').map((p) => p[0]).take(2).join().toUpperCase();

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF161619),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF252530), width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ator.nome,
                      style: const TextStyle(
                        color: Color(0xFFD4D4D8),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${ator.personagem} · ${ator.idade} anos',
                      style: const TextStyle(
                        color: Color(0xFF505058),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
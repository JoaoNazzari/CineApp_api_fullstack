class Filme {
  final int id;
  final String titulo;
  final String genero;
  final String duracao;
  final int faixaEtaria;
  final String? imagemUrl;

  Filme({
    required this.id,
    required this.titulo,
    required this.genero,
    required this.duracao,
    required this.faixaEtaria,
    this.imagemUrl,
  });

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      id: json['id'] as int,
      titulo: json['titulo'] as String,
      genero: json['genero'] as String,
      duracao: json['duracao'] as String,
      faixaEtaria: json['faixaEtaria'] as int,
      imagemUrl: json['imagemUrl'] as String?,
    );
  }
}
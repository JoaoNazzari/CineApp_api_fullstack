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

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      genero: map['genero'] as String,
      duracao: map['duracao'] as String,
      faixaEtaria: map['faixaEtaria'] as int,
      imagemUrl: map['imagemUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'genero': genero,
      'duracao': duracao,
      'faixaEtaria': faixaEtaria,
      'imagemUrl': imagemUrl,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'genero': genero,
      'duracao': duracao,
      'faixaEtaria': faixaEtaria,
      'imagemUrl': imagemUrl,
    };
  }
}

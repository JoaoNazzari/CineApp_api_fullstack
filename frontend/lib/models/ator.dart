class Ator {
    final int id;
    final String nome;
    final String personagem;
    final int idade;
    final int filmeId;

    Ator({
        required this.id,
        required this.nome,
        required this.personagem,
        required this.idade,
        required this.filmeId,
    });

    factory Ator.fromJson(Map<String, dynamic> json) {
        return Ator(
        id: json['id'] as int,
        nome: json['nome'] as String,
        personagem: json['personagem'] as String,
        idade: json['idade'] as int,
        filmeId: json['filmeId'] as int,
        );
    }
}
class Brawler {
  final String nome;
  final int atual;
  final int score;

  const Brawler({
    required this.nome,
    required this.atual,
    required this.score,
  });

  factory Brawler.fromJson(Map<String, dynamic> json, int meta) {
    final trofeus = json["trophies"] ?? 0;
    return Brawler(
      nome: json["name"] ?? "Desconhecido",
      atual: trofeus is int ? trofeus : (trofeus as num).toInt(),
      score: trofeus >= meta ? 0 : (meta - (trofeus as num)).toInt(),
    );
  }
}

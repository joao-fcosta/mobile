class Brawler {
  final String nome;
  final int atual;
  final int faltando;

  Brawler({
    required this.nome,
    required this.atual,
    required this.faltando,
  });

  factory Brawler.fromJson(Map<String, dynamic> json, int meta) {
    final trofeus = json["trophies"] ?? 0;
    return Brawler(
      nome: json["name"] ?? "Desconhecido",
      atual: trofeus,
      faltando: trofeus >= meta ? 0 : (meta - trofeus).toInt(),
    );
  }
}

import '../data/models/brawler.dart';

class TrophyCalculator {
  static Map<String, int> calcularTotais(List<Brawler> brawlers, int meta) {
    int somaAtual = 0;
    int somaComMeta = 0;

    for (var b in brawlers) {
      somaAtual += b.atual;
      somaComMeta += b.atual >= meta ? b.atual : meta;
    }

    return {
      "atual": somaAtual,
      "comMeta": somaComMeta,
      "diferenca": somaComMeta - somaAtual,
    };
  }
}

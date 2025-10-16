import 'package:flutter/material.dart';
import '../../../data/models/brawler.dart';

class BrawlerCard extends StatelessWidget {
  final Brawler brawler;

  const BrawlerCard({super.key, required this.brawler});

  @override
Widget build(BuildContext context) {
  final String nomeFormatado = brawler.nome.replaceAll(' ', '').toLowerCase();
  final String caminhoImagem = 'assets/portrait/${nomeFormatado}_portrait.png';
  const Color corPrincipal = Color(0xFF867888);
  int estrelas = (brawler.score / 10).clamp(1, 6).toInt();

  return Card(
    color: corPrincipal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // 📸 Imagem com borda e cantos retos
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Image.asset(
              caminhoImagem,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, color: Colors.black),
            ),
          ),
          const SizedBox(width: 10),

          // 🧱 Nome e troféus
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brawler.nome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                    shadows: [
                      Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Troféus: ${brawler.atual}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/icons/icon_trophy.png',
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🌟 Estrelas
          Wrap(
            spacing: 2,
            children: List.generate(6, (index) {
              return Image.asset(
                index < estrelas
                    ? 'assets/icons/icon_star.png'
                    : 'assets/icons/icon_star.png',
                width: 17,
                height: 17,
              );
            }),
          ),
        ],
      ),
    ),
  );
}
}

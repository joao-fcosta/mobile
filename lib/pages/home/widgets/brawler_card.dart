import 'package:flutter/material.dart';
import '../../../data/models/brawler.dart';

class BrawlerCard extends StatelessWidget {
  final Brawler brawler;

  const BrawlerCard({super.key, required this.brawler});

  @override
  Widget build(BuildContext context) {
    final String nomeFormatado = brawler.nome.replaceAll(' ', '').toLowerCase();
    final String caminhoImagem = '/portrait/${nomeFormatado}_portrait.png';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            caminhoImagem,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported, size: 40),
          ),
        ),
        title: Text(brawler.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text('Atual: ${brawler.atual}  •  Faltando: ${brawler.faltando}'),
        trailing: Text('${brawler.atual}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

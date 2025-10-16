import 'package:flutter/material.dart';
import '../../../../home/widgets/brawler_card.dart';
import '../../../../home/widgets/totals_header.dart';
import '../../../../../data/models/brawler.dart';

class BrawlerSampleScreen extends StatelessWidget {
  const BrawlerSampleScreen({super.key});

  List<Brawler> _sampleBrawlers() {
    return const [
      Brawler(nome: 'Bull', atual: 650, score: 1000),
      Brawler(nome: 'Colt', atual: 800, score: 900),
      Brawler(nome: 'Shelly', atual: 1200, score: 888),
      Brawler(nome: 'Spike', atual: 1500, score: 789),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final brawlers = _sampleBrawlers();
    final totalAtual = brawlers.fold<int>(0, (s, b) => s + b.atual);
    final totalComMeta = brawlers.fold<int>(0, (s, b) => s + (b.atual + b.score));

    return Scaffold(
      backgroundColor: const Color(0xFF2B5CDD),
      appBar: AppBar(
      title: const Text('Brawlers'),
      backgroundColor: const Color(0xFF478CEE), // Um azul mais claro para a AppBar
      foregroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalsHeader(
              totalAtual: totalAtual,
              totalComMeta: totalComMeta,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: brawlers.length,
                itemBuilder: (context, index) {
                  return BrawlerCard(brawler: brawlers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

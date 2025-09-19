import 'package:flutter/material.dart';
import '../../data/api/brawlstars_api.dart';
import '../../data/models/brawler.dart';
import '../../services/trophy_calculator.dart';
import 'widgets/brawler_card.dart';
import 'widgets/totals_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _metaController = TextEditingController();

  bool loading = false;
  int? totalAtual;
  int? totalComMeta;
  int? diferenca;
  List<Brawler> brawlers = [];

  Future<void> calcular() async {
    final tag = _tagController.text.trim();
    final meta = int.tryParse(_metaController.text.trim()) ?? 0;

    if (tag.isEmpty || meta <= 0) return;

    setState(() => loading = true);

    try {
      final lista = await BrawlStarsApi.buscarBrawlers(tag, meta);
      lista.sort((a, b) => b.atual.compareTo(a.atual));
      final totais = TrophyCalculator.calcularTotais(lista, meta);

      setState(() {
        brawlers = lista;
        totalAtual = totais["atual"];
        totalComMeta = totais["comMeta"];
        diferenca = totais["diferenca"];
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Brawl Stars - Meta de Troféus")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tagController,
              decoration: const InputDecoration(
                labelText: "Digite sua TAG (sem #)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _metaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Meta de troféus por brawler (ex: 700)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: calcular,
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),
            if (loading) const CircularProgressIndicator(),
            if (!loading && totalAtual != null)
              Expanded(
                child: Column(
                  children: [
                    TotalsHeader(
                      totalAtual: totalAtual!,
                      totalComMeta: totalComMeta!,
                      diferenca: diferenca!,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: brawlers.length,
                        itemBuilder: (context, i) =>
                            BrawlerCard(brawler: brawlers[i]),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

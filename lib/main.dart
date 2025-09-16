import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Constantes
const String apiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImRkMWRhNDczLTlhZTAtNGZiOS05NTk5LTY1NjBiZGJhY2U3ZCIsImlhdCI6MTc1ODA0MDMxOSwic3ViIjoiZGV2ZWxvcGVyLzRhZTBhMjVlLTc2ZjEtYzM0Yy01MTMyLTllMzdjYWJlOWRhZiIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiNDUuMjM0LjEzNy4zOSJdLCJ0eXBlIjoiY2xpZW50In1dfQ.l-nSQapMWuXEumBJMwi1bAxmHCtmv_TXRmJqbKpzzBgeR7SKH2Oxmyo8dvhsCabPzE8Ha2VWfnbk0szOEQTquA";
void main() {
  runApp(const MyApp());
}

// Widget principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brawl Stars - Meta de Troféus',
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'lilitaone-regular-webfont',
            ),
      ),
      home: const HomePage(),
    );
  }
}

// Página inicial
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

  // Busca dados do jogador na API e calcula os troféus
  Future<void> calcularTrofeus(String playerTag, int meta) async {
    if (playerTag.isEmpty || meta <= 0) return;

    setState(() {
      loading = true;
      totalAtual = null;
      totalComMeta = null;
    });

    final url = Uri.parse("https://api.brawlstars.com/v1/players/%23$playerTag");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $apiToken"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final brawlers = List<Map<String, dynamic>>.from(data["brawlers"]);

      int somaAtual = 0;
      int somaComMeta = 0;

      for (var b in brawlers) {
        final int trofeus = b["trophies"] ?? 0;
        somaAtual += trofeus;
        somaComMeta += trofeus >= meta ? trofeus : meta;
      }

      setState(() {
        totalAtual = somaAtual;
        totalComMeta = somaComMeta;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: ${response.body}")),
      );
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
            // Campo da TAG
            TextField(
              controller: _tagController,
              decoration: const InputDecoration(
                labelText: "Digite sua TAG (sem #)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Campo da meta
            TextField(
              controller: _metaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Meta de troféus por brawler (ex: 700)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Botão de buscar
            ElevatedButton(
              onPressed: () {
                final tag = _tagController.text.trim();
                final meta = int.tryParse(_metaController.text.trim()) ?? 0;
                calcularTrofeus(tag, meta);
              },
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),

            // Loading
            if (loading) const CircularProgressIndicator(),

            // Resultado
            if (!loading && totalAtual != null && totalComMeta != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Troféus atuais: $totalAtual",
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 10),
                      Text("Troféus com meta: $totalComMeta",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                        "Diferença: ${totalComMeta! - totalAtual!}",
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
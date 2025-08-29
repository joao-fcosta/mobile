import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Constantes
const String apiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjM2MmZkMjUyLWUzOTktNGIwNi05OTIxLTAyZjJiMzMxZTVhYyIsImlhdCI6MTc1NjQyNjEyOSwic3ViIjoiZGV2ZWxvcGVyLzRhZTBhMjVlLTc2ZjEtYzM0Yy01MTMyLTllMzdjYWJlOWRhZiIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMTcwLjIzOS4yMjUuMjYiXSwidHlwZSI6ImNsaWVudCJ9XX0.43iyiWvoQPkrk-dwVnHaNOY3VRb58dBPS1PoGnzHn3c75ZLUePINodSXBXDk6rrclrvqtf8Jm-5mNUcghQtDYA"; // coloque sua chave aqui

void main() {
  runApp(const MyApp());
}

// Widget principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brawl Stars Helper',
      theme: ThemeData.dark(),
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
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> recomendados = [];
  bool loading = false;

  // Busca dados do jogador na API
  Future<void> buscarPlayer(String playerTag) async {
    if (playerTag.isEmpty) return;

    setState(() => loading = true);

    final url = Uri.parse("https://api.brawlstars.com/v1/players/%23$playerTag");
    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $apiToken"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final brawlers = List<Map<String, dynamic>>.from(data["brawlers"]);
      setState(() {
        recomendados = analisarBrawlers(brawlers);
      });
    } else {
      // Exibe erro para o usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: ${response.body}")),
      );
    }

    setState(() => loading = false);
  }

  // Analisa os brawlers e calcula o score
  List<Map<String, dynamic>> analisarBrawlers(List<Map<String, dynamic>> brawlers) {
    return brawlers.map((b) {
      int score = 0;
      score += ((1000 - b["trophies"]).clamp(0, 10000) ~/ 1);
      score += ((b["power"] ?? 0) as int) * 1;
      score += ((b["starPowers"]?.length ?? 0) as int) * 1;
      score += ((b["gadgets"]?.length ?? 0) as int) * 1;
      score += ((b["gears"]?.length ?? 0) as int) * 1;

      return {
        "nome": b["name"],
        "trofeus": b["trophies"],
        "nivel": b["power"],
        "score": score,
      };
    }).toList()
      ..sort((a, b) => b["score"].compareTo(a["score"]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Brawl Stars Helper")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _TagInputField(controller: _controller, onSubmitted: buscarPlayer),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => buscarPlayer(_controller.text.trim()),
              child: const Text("Buscar"),
            ),
            const SizedBox(height: 20),
            if (loading)
              const CircularProgressIndicator()
            else if (recomendados.isNotEmpty)
              Expanded(child: _BrawlerList(brawlers: recomendados)),
          ],
        ),
      ),
    );
  }
}

// Widget para campo de entrada da tag
class _TagInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const _TagInputField({
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: "Digite sua tag (sem #)",
        border: OutlineInputBorder(),
      ),
      onSubmitted: onSubmitted,
    );
  }
}

// Widget para lista de brawlers recomendados
class _BrawlerList extends StatelessWidget {
  final List<Map<String, dynamic>> brawlers;

  const _BrawlerList({required this.brawlers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: brawlers.length,
      itemBuilder: (context, index) {
        final b = brawlers[index];
        return Card(
          child: ListTile(
            title: Text("${b["nome"]} - Score: ${b["score"]}"),
            subtitle: Text("🏆 ${b["trofeus"]} | 🔋 Nível ${b["nivel"]}"),
          ),
        );
      },
    );
  }
}

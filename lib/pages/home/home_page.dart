import 'package:flutter/material.dart';
import '../../data/api/brawlstars_api.dart';
import '../../data/models/brawler.dart';
import '../../services/trophy_calculator.dart';
import 'Components/InputField/input_text.dart'; // Corrigido para StyledInputField
import 'Components/InputField/input_text_view_model.dart';
import 'Components/Buttons/ActionButton/action_button.dart';
import 'Components/Buttons/ActionButton/action_button_view_model.dart';
import 'widgets/brawler_card.dart';
import 'widgets/totals_header.dart';
import '../home/shared/styles.dart';
import '../design/design.dart';

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
    final meta = 700;

    if (tag.isEmpty || meta <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Por favor, preencha a TAG e a Meta.")));
      return;
    }

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
          .showSnackBar(SnackBar(content: Text("Erro: ${e.toString()}")));
    } finally { // Use finally para garantir que o loading seja desativado
      setState(() => loading = false);
    }
  }
  // Dentro da classe _HomePageState
  void _navigateToDesignPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ButtonScreen(), // Navega para o widget Desing
      ),
    );
  }

  @override
  void dispose() {
    _tagController.dispose();
    _metaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B5CDD), // Um azul escuro para o fundo
      appBar: AppBar(
        title: const Text("MANU BRAWL"),
        backgroundColor: const Color(0xFF478CEE), // Um azul mais claro para a AppBar
        foregroundColor: Colors.white,
        actions: [ // <-- Use a propriedade 'actions' que recebe uma lista de Widgets
          ActionButton.instantiate(
            viewModel: ActionButtonViewModel(
              size: ActionButtonSize.small,
              style: ActionButtonStyle.secondary,
              text: "Design",
              onPressed: _navigateToDesignPage,
              
            ),
          ),
        ],
         // Cor do texto e ícones na AppBar
        elevation: 4, // Adiciona uma pequena sombra para destacar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('TAG:', style: button1Bold, textAlign: TextAlign.left),
            StyledInputField.instantiate( // Certifique-se que o import está correto (input_text.dart -> input_text.dart)
              viewModel: InputTextViewModel(
                controller: _tagController,
                placeholder: "",
                password: false,
              ),
            ),
            /* /* const SizedBox(height: 12),
            StyledInputField.instantiate(
              viewModel: InputTextViewModel(
                controller: _metaController,
                placeholder: "Meta de troféus por brawler (ex: 700)",
                password: false,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return "Obrigatório";
                  if (int.tryParse(value.trim()) == null) return "Digite um número válido";
                  return null;
                },
              ), */
            ), */
            const SizedBox(height: 12),
            ActionButton.instantiate(
              viewModel: ActionButtonViewModel(
                size: ActionButtonSize.large,
                style: ActionButtonStyle.secondary,
                text: "BUSCAR",
                onPressed: calcular,
              ),
            ),
            const SizedBox(height: 20),
            if (loading) 
              const CircularProgressIndicator(
                color: Color(0xFF007BFF), // Cor azul para o indicador de progresso
              ),
            if (!loading && totalAtual != null)
              Expanded(
                child: Column(
                  children: [
                    TotalsHeader(
                      totalAtual: totalAtual!,
                      totalComMeta: totalComMeta!,
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
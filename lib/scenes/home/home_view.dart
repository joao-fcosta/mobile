import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Spinner/spinner.dart';
import '../../DesignSystem/Components/Spinner/spinner_view_model.dart';
import '../../resources/shared/colors.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Controllers
  final yearCtrl = TextEditingController();
  final makeCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final engineCtrl = TextEditingController();
  final cylindersCtrl = TextEditingController();
  final classCtrl = TextEditingController();
  final transmissionCtrl = TextEditingController();
  final fuelCtrl = TextEditingController();
  final distanceCtrl = TextEditingController();

  bool _isLoading = false;
  Map<String, dynamic>? _result;

  @override
  void dispose() {
    yearCtrl.dispose();
    makeCtrl.dispose();
    modelCtrl.dispose();
    engineCtrl.dispose();
    cylindersCtrl.dispose();
    classCtrl.dispose();
    transmissionCtrl.dispose();
    fuelCtrl.dispose();
    distanceCtrl.dispose();
    super.dispose();
  }

  Future<void> _consultar() async {
    setState(() {
      _isLoading = true;
      _result = null;
    });

    final body = {
      "year": int.tryParse(yearCtrl.text) ?? 2000,
      "make": makeCtrl.text,
      "model": modelCtrl.text,
      "enginesize": double.tryParse(engineCtrl.text) ?? 2.0,
      "cylinders": int.tryParse(cylindersCtrl.text) ?? 4,
      "vehicleclass": classCtrl.text,
      "transmission": transmissionCtrl.text,
      "fuel": fuelCtrl.text,
      "distance_km": double.tryParse(distanceCtrl.text) ?? 150
    };

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        setState(() => _result = jsonDecode(response.body));
      }
    } catch (e) {
      print("Erro: $e");
    }

    setState(() => _isLoading = false);
  }

  Widget _field(String label, TextEditingController c) {
    return StyledInputField.instantiate(
      viewModel: InputTextViewModel(
        controller: c,
        label: label,
        theme: InputFieldTheme.dark,
      ),
    );
  }

  Widget _buildResult() {
    if (_result == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text("Resultado:",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Text(
          "Consumo L/100km: ${_result!["consumo_l_100km"].toStringAsFixed(2)}\n"
          "Consumo total viagem: ${_result!["consumo_litros_viagem"].toStringAsFixed(2)} L\n"
          "Km por litro: ${_result!["km_por_litro"].toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: neutralBlack.withOpacity(0.9),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Consulta de Consumo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  _field("Ano", yearCtrl),
                  const SizedBox(height: 16),
                  _field("Marca", makeCtrl),
                  const SizedBox(height: 16),
                  _field("Modelo", modelCtrl),
                  const SizedBox(height: 16),
                  _field("Engine Size", engineCtrl),
                  const SizedBox(height: 16),
                  _field("Cilindros", cylindersCtrl),
                  const SizedBox(height: 16),
                  _field("Classe do Veículo", classCtrl),
                  const SizedBox(height: 16),
                  _field("Transmissão", transmissionCtrl),
                  const SizedBox(height: 16),
                  _field("Combustível", fuelCtrl),
                  const SizedBox(height: 16),
                  _field("Distância (KM)", distanceCtrl),
                  const SizedBox(height: 32),

                  ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      size: ActionButtonSize.large,
                      style: ActionButtonStyle.primary,
                      text: "Consultar",
                      onPressed: _consultar,
                    ),
                  ),

                  _buildResult(),
                ],
              ),
            ),
          ),
        ),

        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: SpinnerComponent.instantiate(
              viewModel: SpinnerViewModel(
                color: brandPrimary,
                size: 50.0,
              ),
            ),
          )
      ],
    );
  }
}

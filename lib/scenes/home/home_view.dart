import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Spinner/spinner.dart';
import '../../DesignSystem/Components/Spinner/spinner_view_model.dart';
import '../../DesignSystem/Components/Result/result.dart';
  import 'home_service.dart';
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

  final result = await ConsumoService.consultarConsumo(body);

  setState(() {
    _result = result;
    _isLoading = false;
  });
}

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF020617).withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => widget.viewModel.presentHome(),
            child: Icon(
              Icons.logout,
              color: Colors.white.withOpacity(0.8),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: brandPrimary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Icon(
              Icons.local_gas_station_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'ContaLitro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Dados do Veículo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Preencha as informações para calcular o\nconsumo',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    String? hint,
    IconData? icon,
  }) {
    return StyledInputField.instantiate(
      viewModel: InputTextViewModel(
        controller: controller,
        label: label,
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(
                icon,
                size: 18,
                color: Colors.white.withOpacity(0.8),
              )
            : null,
        enableClearButton: false,
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF020617).withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [
          // Ano / Fabricante
          Row(
            children: [
              Expanded(
                child: _field(
                  label: 'Ano',
                  controller: yearCtrl,
                  hint: '2025',
                  icon: Icons.calendar_today_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  label: 'Fabricante',
                  controller: makeCtrl,
                  hint: 'Marca',
                  icon: Icons.directions_car_filled_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Modelo
          _field(
            label: 'Modelo',
            controller: modelCtrl,
            hint: 'Ex: INTEGRA, CIVIC, COROLLA',
            icon: Icons.directions_car_outlined,
          ),
          const SizedBox(height: 16),

          // Motor / Cilindros
          Row(
            children: [
              Expanded(
                child: _field(
                  label: 'Motor',
                  controller: engineCtrl,
                  hint: '1.0L',
                  icon: Icons.speed_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  label: 'Cilindros',
                  controller: cylindersCtrl,
                  hint: '4 cilindros',
                  icon: Icons.auto_awesome_motion_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _field(
            label: 'Classe do Veículo',
            controller: classCtrl,
            hint: 'Selecione a classe',
            icon: Icons.category_outlined,
          ),
          const SizedBox(height: 16),

          _field(
            label: 'Transmissão',
            controller: transmissionCtrl,
            hint: 'Tipo de câmbio',
            icon: Icons.settings_suggest_outlined,
          ),
          const SizedBox(height: 16),

          _field(
            label: 'Combustível',
            controller: fuelCtrl,
            hint: 'Tipo de combustível',
            icon: Icons.local_gas_station_outlined,
          ),
          const SizedBox(height: 16),

          _field(
            label: 'Distância da Viagem (km)',
            controller: distanceCtrl,
            hint: '100',
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ActionButton.instantiate(
            viewModel: ActionButtonViewModel(
              size: ActionButtonSize.large,
              style: ActionButtonStyle.primary,
              text: "Calcular Consumo",
              onPressed: _consultar,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Preencha todos os campos para continuar',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildResult() {
    if (_result == null) return const SizedBox.shrink();
    return ResultCard(result: _result!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF020617),
                  Color(0xFF020617),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          _buildHeader(),
                          _buildFormCard(),
                          _buildResult(),
                          const SizedBox(height: 90), // respiro pro botão
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                    child: _buildBottomSection(),
                  ),
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
          ),
      ],
    );
  }
}

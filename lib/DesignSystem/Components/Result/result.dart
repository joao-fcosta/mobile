import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultCard({
    super.key,
    required this.result,
  });

  Widget _buildItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$label: ",
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0F1F).withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.06),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com linha de destaque
            Row(
              children: [
                const Text(
                  'Resultado',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 2,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildItem(
              Icons.local_gas_station,
              "Consumo L/100km",
              result["consumo_l_100km"].toStringAsFixed(2),
            ),
            _buildItem(
              Icons.route,
              "Consumo total da viagem",
              "${result["consumo_litros_viagem"].toStringAsFixed(2)} L",
            ),
            _buildItem(
              Icons.speed,
              "Km por litro",
              result["km_por_litro"].toStringAsFixed(2),
            ),
          ],
        ),
      ).animate().fadeIn().slideY(begin: 0.15, duration: 450.ms),
    );
  }
}

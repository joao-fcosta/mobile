import 'package:flutter/material.dart';

class TotalsHeader extends StatelessWidget {
  final int totalAtual;
  final int totalComMeta;
  final int diferenca;

  const TotalsHeader({
    super.key,
    required this.totalAtual,
    required this.totalComMeta,
    required this.diferenca,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = Theme.of(context).textTheme.bodyMedium!;
    final TextStyle valueStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Troféus atuais: $totalAtual', style: labelStyle),
        const SizedBox(height: 8),
        Text('Troféus com meta: $totalComMeta', style: valueStyle),
        const SizedBox(height: 6),
        Text(
          'Diferença: $diferenca',
          style: TextStyle(
            color: diferenca >= 0 ? Colors.greenAccent : Colors.redAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Divider(height: 30),
      ],
    );
  }
}

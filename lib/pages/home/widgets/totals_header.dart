import 'package:flutter/material.dart';

class TotalsHeader extends StatelessWidget {
  final int totalAtual;
  final int totalComMeta;

  const TotalsHeader({
    super.key,
    required this.totalAtual,
    required this.totalComMeta
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
        /* Text('Troféus atuais: $totalAtual', style: labelStyle),
        const SizedBox(height: 8), */
        Text('Troféus atuais: $totalAtual', style: valueStyle),
        const Divider(height: 30),
      ],
    );
  }
}

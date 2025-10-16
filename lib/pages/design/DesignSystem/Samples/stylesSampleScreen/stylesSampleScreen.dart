import 'package:flutter/material.dart';
import '../../../../home/shared/styles.dart';
import '../../../../home/shared/colors.dart';

const String _kSampleText = 'Exemplo de Texto (Brawl Stars)';

const List<Map<String, dynamic>> _kTextStylesSamples = [
  {'name': 'heading1Light', 'style': heading1Light},
  {'name': 'heading2Light', 'style': heading2Light},
  {'name': 'heading3Regular', 'style': heading3Regular},
  {'name': 'heading4Regular', 'style': heading4Regular},
  {'name': 'heading5Regular', 'style': heading5Regular},
  {'name': 'subtitle1Regular', 'style': subtitle1Regular},
  {'name': 'subtitle2Medium', 'style': subtitle2Medium},
  {'name': 'paragraph1Regular', 'style': paragraph1Regular},
  {'name': 'paragraph2Medium', 'style': paragraph2Medium},
  {'name': 'label1Semibold', 'style': label1Semibold},
  {'name': 'label2Regular', 'style': label2Regular},
  {'name': 'label2Semibold', 'style': label2Semibold},
  {'name': 'button1Bold', 'style': button1Bold},
  {'name': 'button2Semibold', 'style': button2Semibold},
  {'name': 'button3Semibold', 'style': button3Semibold},
];

class StylesSampleScreen extends StatelessWidget {
  const StylesSampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Styles Showcase'),
        backgroundColor: const Color(0xFF478CEE), // Um azul mais claro para a AppBar
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF2B5CDD),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        itemCount: _kTextStylesSamples.length,
        itemBuilder: (context, index) {
          final styleData = _kTextStylesSamples[index];
          return _StyleDisplay(
            name: styleData['name'] as String,
            style: styleData['style'] as TextStyle,
          );
        },
      ),
    );
  }
}

class _StyleDisplay extends StatelessWidget {
  final String name;
  final TextStyle style;

  const _StyleDisplay({
    required this.name,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final nameStyle = Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(
            color: lightPrimaryBaseColorDark, 
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace'); 

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: nameStyle),
          const SizedBox(height: 6),
          Text(
            _kSampleText,
            style: style.copyWith(color: lightPrimaryBaseColorDark),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Divider(
              color: Color.fromARGB(255, 200, 200, 200), 
              height: 1, 
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
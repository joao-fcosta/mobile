import 'package:flutter/material.dart';
import '../../../../home/shared/colors.dart';

// 1. Extração da lista de cores para uma constante de nível superior
const List<Map<String, dynamic>> _kColorSections = [
  {
    'title': 'Brand Colors (Marca)',
    'colors': [
      {'name': 'lightPrimaryBrandColor', 'color': lightPrimaryBrandColor},
      {'name': 'normalPrimaryBrandColor', 'color': normalPrimaryBrandColor},
      {'name': 'darkPrimaryBrandColor', 'color': darkPrimaryBrandColor},
    ],
  },
  {
    'title': 'Secondary Colors (Secundária)',
    'colors': [
      {'name': 'lightSecondaryBrandColor', 'color': lightSecondaryBrandColor},
      {'name': 'normalSecondaryBrandColor', 'color': normalSecondaryBrandColor},
      {'name': 'darkSecondaryBrandColor', 'color': darkSecondaryBrandColor},
    ],
  },
  {
    'title': 'Accent Colors (Destaque)',
    'colors': [
      {'name': 'lightTertiaryBrandColor', 'color': lightTertiaryBrandColor},
      {'name': 'normalTertiaryBrandColor', 'color': normalTertiaryBrandColor},
      {'name': 'darkTertiaryBrandColor', 'color': darkTertiaryBrandColor},
    ],
  },
  {
    'title': 'Base Colors (Claro)',
    'colors': [
      {'name': 'lightPrimaryBaseColorLight', 'color': lightPrimaryBaseColorLight},
      {'name': 'normalPrimaryBaseColorLight', 'color': normalPrimaryBaseColorLight},
      {'name': 'darkPrimaryBaseColorLight', 'color': darkPrimaryBaseColorLight},
      {'name': 'lightSecondaryBaseColorLight', 'color': lightSecondaryBaseColorLight},
      {'name': 'normalSecondaryBaseColorLight', 'color': normalSecondaryBaseColorLight},
      {'name': 'darkSecondaryBaseColorLight', 'color': darkSecondaryBaseColorLight},
      {'name': 'lightTertiaryBaseColorLight', 'color': lightTertiaryBaseColorLight},
      {'name': 'normalTertiaryBaseColorLight', 'color': normalTertiaryBaseColorLight},
      {'name': 'darkTertiaryBaseColorLight', 'color': darkTertiaryBaseColorLight},
    ],
  },
  {
    'title': 'Base Colors (Escuro)',
    'colors': [
      {'name': 'lightPrimaryBaseColorDark', 'color': lightPrimaryBaseColorDark},
      {'name': 'normalPrimaryBaseColorDark', 'color': normalPrimaryBaseColorDark},
      {'name': 'darkPrimaryBaseColorDark', 'color': darkPrimaryBaseColorDark},
      {'name': 'lightSecondaryBaseColorDark', 'color': lightSecondaryBaseColorDark},
      {'name': 'normalSecondaryBaseColorDark', 'color': normalSecondaryBaseColorDark},
      {'name': 'darkSecondaryBaseColorDark', 'color': darkSecondaryBaseColorDark},
      {'name': 'lightTertiaryBaseColorDark', 'color': lightTertiaryBaseColorDark},
      {'name': 'normalTertiaryBaseColorDark', 'color': normalTertiaryBaseColorDark},
      {'name': 'darkTertiaryBaseColorDark', 'color': darkTertiaryBaseColorDark},
    ],
  },
  {
    'title': 'System Colors (Sistema)',
    'colors': [
      {'name': 'lightSuccessSystemColor', 'color': lightSuccessSystemColor},
      {'name': 'normalSuccessSystemColor', 'color': normalSuccessSystemColor},
      {'name': 'darkSuccessSystemColor', 'color': darkSuccessSystemColor},
      {'name': 'lightErrorSystemColor', 'color': lightErrorSystemColor},
      {'name': 'normalErrorSystemColor', 'color': normalErrorSystemColor},
      {'name': 'darkErrorSystemColor', 'color': darkErrorSystemColor},
    ],
  },
  {
    'title': 'Material Overlay Colors (Claro)',
    'colors': [
      {'name': 'thickMaterialColorLight', 'color': thickMaterialColorLight},
      {'name': 'regularMaterialColorLight', 'color': regularMaterialColorLight},
      {'name': 'thinMaterialColorLight', 'color': thinMaterialColorLight},
      {'name': 'ultrathinMaterialColorLight', 'color': ultrathinMaterialColorLight},
    ],
  },
  {
    'title': 'Material Colors (Escuro)',
    'colors': [
      {'name': 'thickMaterialColorDark', 'color': thickMaterialColorDark},
      {'name': 'regularMaterialColorDark', 'color': regularMaterialColorDark},
      {'name': 'thinMaterialColorDark', 'color': thinMaterialColorDark},
      {'name': 'ultrathinMaterialColorDark', 'color': ultrathinMaterialColorDark},
    ],
  },
];

class ColorsSampleScreen extends StatelessWidget {
  const ColorsSampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Definindo um fundo claro no corpo (body) para melhorar o contraste
    // com as cores escuras de base, e assim, todas as cores.
    return Scaffold(
      backgroundColor: const Color(0xFF2B5CDD),
      appBar: AppBar(
        title: const Text('Color Palette Showcase'),
        backgroundColor: const Color(0xFF478CEE), // Cor da AppBar escura
        foregroundColor: Colors.white, // Título branco
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        itemCount: _kColorSections.length,
        itemBuilder: (context, index) {
          final section = _kColorSections[index];
          // 3. Tipagem segura (cast)
          return _ColorSection(
            title: section['title'] as String,
            colors: section['colors'] as List<Map<String, dynamic>>,
          );
        },
      ),
    );
  }
}

class _ColorSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> colors;

  const _ColorSection({required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    // 4. Estilo de Título claro para o fundo branco
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black87, // Título quase preto no fundo branco
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          // 5. Usando Column para os itens, que já é o padrão
          Column(
            children: colors.map((colorData) {
              return _ColorTile(
                name: colorData['name'] as String,
                color: colorData['color'] as Color,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ColorTile extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorTile({required this.name, required this.color});

  // 6. Função para converter cor para Hex, mantendo a estrutura
  String _toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  // 7. Função para determinar a cor do texto (preto ou branco) com base no brilho
  // da cor de fundo (Color Tile).
  Color get _textColor {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white // Cor de fundo escura -> Texto branco
        : Colors.black; // Cor de fundo clara -> Texto preto
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        // Removendo a borda branca (white24) que pode sumir em algumas cores claras
        // Adicionando uma sombra sutil para melhor definição.
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              name,
              style: TextStyle(
                color: _textColor,
                fontWeight: FontWeight.w500, // Levemente mais fino que Bold
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _toHex(color),
            style: TextStyle(
              color: _textColor,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold, // Hex em negrito para destaque
            ),
          ),
        ],
      ),
    );
  }
}
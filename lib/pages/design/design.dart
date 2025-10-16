import 'package:flutter/material.dart';
import '../design/DesignSystem/Samples/actionButtonSampleScreen/action_button_sample_screen.dart';
import '../design/DesignSystem/Samples/colorsSampleScreen/colorsSampleScreen.dart';
import '../design/DesignSystem/Samples/stylesSampleScreen/stylesSampleScreen.dart';
import '../design/DesignSystem/Samples/inputFieldSampleScreen/input_field_sample_screen.dart';
import '../design/DesignSystem/Samples/brawlerSampleScreen/brawler_sample_screen.dart';
import '../home/shared/colors.dart';
import '../home/Components/Buttons/ActionButton/action_button.dart';
import '../home/Components/Buttons/ActionButton/action_button_view_model.dart';

void main() {
  runApp(const Design());
}

class Design extends StatelessWidget {
  const Design({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkSecondaryBrandColor),
        fontFamily: 'lilitaone-regular-webfont',
        useMaterial3: true,
      ),
      home: const ButtonScreen(),
    );
  }
}

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B5CDD),
      appBar: AppBar(
        title: const Text('Design System'),
        backgroundColor: const Color(0xFF478CEE), // Um azul mais claro para a AppBar
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.medium,
                  style: ActionButtonStyle.secondary,
                  text: 'Action Button',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActionButtonPage()),
                    );
                  },
                ),
              ),
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.medium,
                  style: ActionButtonStyle.secondary,
                  text: 'Input Text Field',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputFieldPage()),
                    );
                  },
                ),
              ),
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.medium,
                  style: ActionButtonStyle.secondary,
                  text: 'Brawlers Sample',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BrawlerSampleScreen()),
                    );
                  },
                ),
              ),
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.medium,
                  style: ActionButtonStyle.secondary,
                  text: 'Color Palette',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ColorsSampleScreen()),
                    );
                  },
                ),
              ),
              ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.medium,
                  style: ActionButtonStyle.secondary,
                  text: 'Text Styles Showcase',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StylesSampleScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildButton(BuildContext context, String text, Widget scene) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => scene),
        );
      },
      child: Text(text),
    );
  }
}
// Additional scene widgets were removed because they were not referenced
// anywhere in the project. Keep this comment if you need to restore them.
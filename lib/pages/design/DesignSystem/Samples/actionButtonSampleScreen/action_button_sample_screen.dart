import 'package:flutter/material.dart';
import '../../../../home/Components/Buttons/ActionButton/action_button.dart';
import '../../../../home/Components/Buttons/ActionButton/action_button_view_model.dart';



class ActionButtonPage extends StatelessWidget {
  const ActionButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B5CDD),
      appBar: AppBar(
        title: const Text('Styled Button Demo'),
        backgroundColor: const Color(0xFF478CEE), // Um azul mais claro para a AppBar
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.large,
                        style: ActionButtonStyle.primary,
                        text: 'Large',
                        onPressed: () {}
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.medium,
                        style: ActionButtonStyle.primary,
                        text: 'Medium',
                        onPressed: () {}
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.small,
                        style: ActionButtonStyle.primary,
                        text: 'Small',
                        onPressed: () {}
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.large,
                        style: ActionButtonStyle.secondary,
                        text: 'Large',
                        icon: Icons.search,
                        onPressed: () {},
                        isEnabled: false
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.medium,
                        style: ActionButtonStyle.secondary,
                        text: 'Medium',
                        icon: Icons.navigate_next_outlined,
                        onPressed: () {}
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.small,
                        style: ActionButtonStyle.secondary,
                        text: 'Small',
                        onPressed: () {}
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.large,
                        style: ActionButtonStyle.tertiary,
                        text: 'Large',
                        onPressed: () {},
                        isEnabled: false,
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.medium,
                        style: ActionButtonStyle.tertiary,
                        text: 'Medium',
                        icon: Icons.navigate_next_outlined,
                        onPressed: () {},
                        isEnabled: false,
                      )
                    ),
                    const SizedBox(height: 10,),
                    ActionButton.instantiate(viewModel: 
                      ActionButtonViewModel(
                        size: ActionButtonSize.small,
                        style: ActionButtonStyle.tertiary,
                        icon: Icons.navigate_next_outlined,
                        text: 'Small',
                        onPressed: () {},
                      )
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
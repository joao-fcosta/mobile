import 'package:flutter/material.dart';
import 'spinner_view_model.dart';

class SpinnerComponent extends StatelessWidget {
  final SpinnerViewModel viewModel;

  const SpinnerComponent._({super.key, required this.viewModel});

  static Widget instantiate({required SpinnerViewModel viewModel}) {
    return SpinnerComponent._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: viewModel.size,
        height: viewModel.size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(viewModel.color),
        ),
      ),
    );
  }
}
import 'package:fastnotes_bloc/core/config/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingFirstWidget extends StatelessWidget {
  const OnboardingFirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(AssetConstants.notebookLottie),
          Text(
            "FastNotes",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Take notes, fast and easy",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

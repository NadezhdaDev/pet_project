

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CreateScreenLottieWidget extends StatelessWidget {
  const CreateScreenLottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      _getAnimation(),
      repeat: true,
    );
  }

  String _getAnimation() => 'assets/lottie/photo_screen_lottie.json';

}


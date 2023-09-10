
import 'package:flutter/material.dart';

import 'base_animated_scale_button.dart';

class GradientScaleButton extends BaseAnimatedScaleButtonState {
  GradientScaleButton({required super.label, required super.onPressed});

  @override
  Widget button() => DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: const LinearGradient(colors: [Colors.lightBlue, Colors.lightBlueAccent])),
        child: TextButton(
          style: const ButtonStyle(
            overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
          ),
          onPressed: () async {
            await controller.forward();
            await Future.delayed(const Duration(milliseconds: 20));
            controller.reverse();
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(label, style:const TextStyle(color: Colors.blueAccent, fontSize: 20.0)),
          ),
        ),
      );
}

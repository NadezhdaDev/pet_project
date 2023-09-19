import 'package:flutter/material.dart';

import 'base_animated_scale_button.dart';

class RoundedScaleButton extends BaseAnimatedScaleButtonState {
  final Icon? buttonsIcon;

  RoundedScaleButton({required super.onPressed, this.buttonsIcon, super.label});

  @override
  Widget button() => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.0),
          color: Colors.pinkAccent,
          border: Border.all(
            color: Colors.blueAccent,
            width: 2.0,
          ),
        ),
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
            padding: const EdgeInsets.all(10.0),
            child: buttonsIcon?? const Icon(Icons.add),
          ),
        ),
      );
}

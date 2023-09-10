import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class UIImagePainter extends CustomPainter {
  final ui.Image? image;
  final Size? imageSize;
  final Size? canvasSize;

  UIImagePainter({
    required this.image,
    required this.imageSize,
    required this.canvasSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null && imageSize != null) {
      final ui.Image myBackground = image!;

      canvas.drawImageRect(
        myBackground,
        Rect.fromLTWH(0, 0, imageSize!.width, imageSize!.height),
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

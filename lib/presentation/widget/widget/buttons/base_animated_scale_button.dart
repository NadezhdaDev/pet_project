
import 'package:flutter/cupertino.dart';

import '../../../state/state_factory/screen_state_factory.dart';

abstract class BaseAnimatedScaleButtonState extends State<ScreenStateFactory>
    with SingleTickerProviderStateMixin {
  final String? label;
  final Function onPressed;

  BaseAnimatedScaleButtonState({this.label, required this.onPressed});

  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 20),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: button(),
    );
  }

  Widget button();
}

import 'package:flutter/material.dart';

class ScreenStateFactory<T extends State> extends StatefulWidget {
  final Function stateFactory;

  const ScreenStateFactory({super.key, required this.stateFactory});

  @override
  T createState() => stateFactory(); //ignore:no_logic_in_create_state
}

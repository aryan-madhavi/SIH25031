
import 'package:flutter/material.dart';

class DarkButtonWidget extends StatelessWidget {
  final String? buttonLabel;
  final IconData? buttonIcon;
  final VoidCallback buttonOnPress;
  const DarkButtonWidget({
    super.key,
    this.buttonLabel,
    this.buttonIcon,
    required this.buttonOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, style: ButtonStyle(
    
    ), child: Text(""));
  }
}

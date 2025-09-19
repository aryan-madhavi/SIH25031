import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool textHidden;
  final String hintText;
  final IconData? icon;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.textHidden,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: textHidden,
      controller: controller,
      decoration: InputDecoration(
        focusColor: ColorConstants.primaryColorDark,
        prefixIcon: icon == null ? null : Icon(icon),
        filled: true,
        // fillColor: ConstColor.TextfieldBackground,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          // color: ConstColor.normalBlack,
        ),
      ),
    );
  }
}

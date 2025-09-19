import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText = 'must be 8 characters',
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !isVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() => isVisible = !isVisible);
          },
          child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
        ),
        filled: true,
        // fillColor: YourColorConstants.textFieldBackground,
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          // color: ConstColor.normalBlack,
        ),
      ),
    );
  }
}

import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';

class SigninWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String url;
  const SigninWidget({super.key, required this.url, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(ResponsiveService.w(0.02)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Color(0xffD6D6D6)),
        ),
        child: Image.asset(url),
      ),
    );
  }
}

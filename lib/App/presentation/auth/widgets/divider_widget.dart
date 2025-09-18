import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Color(0xff878787))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveService.w(0.025)),
          child: Text(
            "Or Sign in With",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff878787),
            ),
          ),
        ),
        Expanded(child: Divider(color: ColorConstants.darkGreyColor)),
      ],
    );
  }
}

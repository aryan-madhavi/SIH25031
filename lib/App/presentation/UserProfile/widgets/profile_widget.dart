import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String? user_name;
  final String? Phone_number;

  const ProfileWidget({this.Phone_number, this.user_name, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(ResponsiveService.w(0.002)),
          decoration: BoxDecoration(
            color: ColorConstants.darkGreyColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            size: ResponsiveService.w(0.12),
            Icons.person,
            color: ColorConstants.darkAppBarColor,
          ),
        ),

        SizedBox(width: ResponsiveService.w(0.025)),

        //*Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*to display two different text style
            Text(
              user_name ?? '',
              style: TextStyle(
                fontSize: ResponsiveService.fs(0.04),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: ResponsiveService.w(0.0023)),

            Text(
              Phone_number ?? '8657 68145',
              style: TextStyle(
                color: ColorConstants.blackColor,
                fontSize: ResponsiveService.w(0.023),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

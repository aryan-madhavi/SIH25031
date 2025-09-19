import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';

class PhotoEvidenceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveService.w(0.05)),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.darkGreyColor,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              color: ColorConstants.primaryColorLight,
              size: ResponsiveService.w(0.09),
            ),

            SizedBox(height: ResponsiveService.h(0.01)),

            Text(
              "Click to upload",
              style: TextStyle(
                fontSize: ResponsiveService.fs(0.045),
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: ResponsiveService.h(0.05)),

            ElevatedButton.icon(
              onPressed: () {
                // TODO: add upload action
              },
              icon: Icon(Icons.upload_rounded),
              label: Text(
                "Choose File",
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.036),
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  ColorConstants.primaryColorLight,
                ),

                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: ResponsiveService.w(0.03),
                    vertical: ResponsiveService.w(0.03),
                  ),
                ),

                foregroundColor: WidgetStatePropertyAll(Colors.white),

                shadowColor: WidgetStatePropertyAll(
                  ColorConstants.primaryColorDark,
                ),

                elevation: WidgetStatePropertyAll(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

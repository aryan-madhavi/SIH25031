import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/controllers/app_controllers.dart';
import 'package:civic_reporter/App/data/services/permission_services.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/widgets/image_picker_preview.dart';
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
              onPressed: () async {
                // TODO: add upload action
                final permissionService = PermissionServices();
                final appController = AppControllers();

                // Request permissions
                final hasPermission = await permissionService
                    .requestPermissions();
                  
                  

                if (!hasPermission) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Permission denied. Please enable camera and storage.',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImagePickerPreview()),
                );
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

import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/controllers/app_controllers.dart';
import 'package:civic_reporter/App/providers/report_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoEvidenceWidget extends ConsumerWidget {
  const PhotoEvidenceWidget({super.key});

  void showPickerDialog(BuildContext context, WidgetRef ref) {
    final appController = AppControllers();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pick from files/media'),
              onTap: () async {
                Navigator.of(context).pop();
                final file = await appController.pickFileFromStorage();
                if (file != null) {
                  ref.read(reportNotifierProvider.notifier).updatemediaFile(file);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Open Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await appController.pickImageFromCamera();
                if (image != null) {
                  ref.read(reportNotifierProvider.notifier).updatemediaFile(image);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImage = ref.watch(reportNotifierProvider).mediaFile;
    ResponsiveService.init(context);

    //TODO add more functionality to remove /add more images

    if (selectedImage != null) {
      return Container(
        height: ResponsiveService.h(0.4),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: FileImage(selectedImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

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
              onPressed: () => showPickerDialog(context, ref),
              icon: const Icon(Icons.upload_rounded),
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
                elevation: const WidgetStatePropertyAll(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

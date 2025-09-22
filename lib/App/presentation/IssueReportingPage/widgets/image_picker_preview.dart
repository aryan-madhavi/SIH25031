import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/controllers/app_controllers.dart';
import 'package:civic_reporter/App/providers/report_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePickerPreview extends ConsumerWidget {
  const ImagePickerPreview({super.key});

  void showPickerDialog(BuildContext context, WidgetRef ref) {
    final controller = AppControllers();

    //*DIALOGUE WIDGET

    // ImageSourcePickerDialog(controller: controller, ref: ref);
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
                final selectedFile = await controller.pickFileFromStorage();

                if (selectedFile != null) {
                  ref
                      .read(reportNotifierProvider.notifier)
                      .updatemediaFile(selectedFile);
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Open Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                final selectedImage = await controller.pickImageFromCamera();
                if (selectedImage != null) {
                  ref
                      .read(reportNotifierProvider.notifier)
                      .updatemediaFile(selectedImage);
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

    return Scaffold(
      appBar: AppbarWidget(
        'Image Preview',
        Icons.menu,
        true,
        () => Navigator.pop(context),
      ),

      body: Padding(
        //TODO change to Responsive
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            //* Image Container
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            selectedImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              //TODO change to Responsive
                              size: 80,
                              color: Colors.grey.shade600,
                            ),
                            //TODO change to Responsive
                            const SizedBox(height: 10),
                            Text(
                              "No image selected",
                              style: TextStyle(
                                //TODO change to Responsive
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            //TODO change to Responsive
            const SizedBox(height: 24),
            // Action Button
            ElevatedButton.icon(
              onPressed: () => showPickerDialog(context, ref), // Pass ref
              icon: const Icon(Icons.upload_rounded),
              label: const Text("Select Image"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColorLight,
                foregroundColor: Colors.white,
                //TODO change to Responsive
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
            //TODO change to Responsive
            const SizedBox(height: 16),
            // Upload / Continue Button
            if (selectedImage != null)
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: handle upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Uploading image... (stubbed)"),
                    ),
                  );
                },
                icon: const Icon(Icons.cloud_upload_outlined),
                label: const Text("Upload"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryColorDark,
                  foregroundColor: Colors.white,
                  //TODO change to Responsive
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

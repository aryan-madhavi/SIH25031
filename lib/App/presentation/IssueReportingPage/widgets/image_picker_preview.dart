import 'dart:io';
import 'package:civic_reporter/App/controllers/app_controllers.dart';
import 'package:flutter/material.dart';

class ImagePickerPreview extends StatefulWidget {
  const ImagePickerPreview({super.key});

  @override
  State<ImagePickerPreview> createState() => _ImagePickerPreviewState();
}

class _ImagePickerPreviewState extends State<ImagePickerPreview> {
  File? _selectedImage;
  final controller = AppControllers();

  void _showPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Pick from files/media'),
              onTap: () async {
                Navigator.of(context).pop();
                final file = await controller.pickFileFromStorage();
                if (file != null) {
                  setState(() {
                    _selectedImage = file;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Open Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await controller.pickImageFromCamera();
                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Preview')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _showPickerDialog,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 300,
            color: Colors.grey[300],
            child: _selectedImage != null
                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                : Center(child: Text('No image selected')),
          ),
        ],
      ),
    );
  }
}

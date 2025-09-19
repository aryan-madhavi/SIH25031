import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/widgets/photo_evidence_widget.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/widgets/urgency_button_widget.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/text_field_widget.dart';
import 'package:civic_reporter/App/providers/selected_catrgory_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SubmitReportForm extends StatefulWidget {
  const SubmitReportForm({super.key});

  @override
  State<SubmitReportForm> createState() => _SubmitReportFormState();
}

class _SubmitReportFormState extends State<SubmitReportForm> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? selectedCategory;
  String urgency = "Low";

  final List<String> categories = [
    "Road & Transportation",
    "Utilities",
    "Enviroment",
    "Public Safety",
    "Infrastructure",
    "Public Places",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo Upload
          Text(
            "Photo Evidence",
            style: TextStyle(
              fontSize: ResponsiveService.fs(0.045),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: ResponsiveService.h(0.01)),

          GestureDetector(
            onTap: () {
              // TODO: implement file picker
            },
            child: PhotoEvidenceWidget(),
          ),

          SizedBox(height: ResponsiveService.h(0.04)),

          // Category
          Text(
            "Category",
            style: TextStyle(
              fontSize: ResponsiveService.fs(0.045),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: ResponsiveService.h(0.01)),

          Consumer(
            builder: (context, ref, child) {
              return DropdownButtonFormField<String>(
                value: selectedCategory,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                hint: const Text("Select issue category"),

                items: categories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  ref.read(selectedCategoryProvider.notifier).update((state) {
                    return val ?? '';
                  });
                },
              );
            },
          ),

          SizedBox(height: ResponsiveService.h(0.04)),

          // Description
          Text(
            "Description",
            style: TextStyle(
              fontSize: ResponsiveService.fs(0.045),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: ResponsiveService.h(0.01)),

          TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Describe the issue in detail",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          SizedBox(height: ResponsiveService.h(0.045)),

          // Location
          Text(
            "Location",
            style: TextStyle(
              fontSize: ResponsiveService.fs(0.045),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: ResponsiveService.h(0.01)),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: "Enter address or intersection",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveService.h(0.01)),

              Ink(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                  color: ColorConstants.secondaryColor,
                ),
                child: IconButton(
                  tooltip: "Add Current Location",
                  icon: const Icon(Icons.location_on),
                  onPressed: () {
                    // TODO: get current location
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveService.h(0.05)),

          // Urgency Level
          Text(
            "Urgency Level",
            style: TextStyle(
              fontSize: ResponsiveService.fs(0.045),
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: ResponsiveService.h(0.01)),

          Row(
            children: [
              UrgencyButtonWidget(
                label: "Low",
                color: Colors.green,
                icon: Icons.check_circle,
              ),

              SizedBox(width: ResponsiveService.w(0.015)),

              UrgencyButtonWidget(
                label: "Medium",
                color: Colors.orange,
                icon: Icons.warning_amber,
              ),

              SizedBox(width: ResponsiveService.w(0.015)),

              UrgencyButtonWidget(
                label: "High",
                color: Colors.red,
                icon: Icons.error,
              ),
            ],
          ),

          SizedBox(height: ResponsiveService.h(0.09)),

          // Submit Button
         
        ],
      ),
    );
  }
}

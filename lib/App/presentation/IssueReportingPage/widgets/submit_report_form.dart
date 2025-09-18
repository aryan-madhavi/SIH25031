import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:flutter/material.dart';

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
    "Road Issue",
    "Garbage",
    "Street Light",
    "Water Supply",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
           Text(
            StringConstants.submitNewReportTitle,
            style: TextStyle(fontSize: ResponsiveService.h(0.1), fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          const Text(
            "Provide details about the civic issue you'd like to report",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Photo Upload
          Text("Photo Evidence", style: TextStyle()),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // TODO: implement file picker
            },
            child: DottedBorderBox(),
          ),
          const SizedBox(height: 20),

          // Category
          Text("Category", style: TextStyle()),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
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
              setState(() {
                selectedCategory = val;
              });
            },
          ),
          const SizedBox(height: 20),

          // Description
          Text("Description", style: TextStyle()),
          const SizedBox(height: 8),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Describe the issue in detail...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Location
          Text("Location"),
          const SizedBox(height: 8),
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
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.location_on),
                onPressed: () {
                  // TODO: get current location
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Urgency Level
          Text("Urgency Level", style: TextStyle()),
          const SizedBox(height: 8),
          Row(
            children: [
              urgencyButton("Low", Colors.green),
              const SizedBox(width: 8),
              urgencyButton("Medium", Colors.orange),
              const SizedBox(width: 8),
              urgencyButton("High", Colors.red),
            ],
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text(
                "Submit Report",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // TODO: handle submit logic
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget urgencyButton(String label, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            urgency = label;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: urgency == label ? color.withOpacity(0.2) : Colors.grey[900],
            border: Border.all(
              color: urgency == label ? color : Colors.grey.shade700,
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.warning, color: color),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Dashed Box for photo upload
class DottedBorderBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text("Click to upload or drag and drop"),
            SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text("Choose File"),
              onPressed: null, // TODO: add upload action
            ),
          ],
        ),
      ),
    );
  }
}

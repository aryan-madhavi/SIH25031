import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/primary_button_widget.dart';
import 'package:civic_reporter/App/controllers/app_controllers.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/widgets/photo_evidence_widget.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/widgets/urgency_button_widget.dart';
import 'package:civic_reporter/App/providers/report_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SubmitReportForm extends ConsumerStatefulWidget {
  const SubmitReportForm({super.key});

  @override
  ConsumerState<SubmitReportForm> createState() => _SubmitReportFormState();
}

class _SubmitReportFormState extends ConsumerState<SubmitReportForm> {
  final AppControllers appControllers = AppControllers();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Position? currentPosition;
  String? currentAddress;

  void getCurrentPostion() async {
    try {
      Position position = await appControllers.determinePosition();
      List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemark[0];

      String address =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      final GeoPoint locationPoint = GeoPoint(
        position.latitude,
        position.longitude,
      );

      ref.read(reportNotifierProvider.notifier).updatelocation(locationPoint);
      locationController.text = address;

      // setState(() {
      //   currentPosition = position;
      //   currentAddress = address;
      // });
    } catch (e) {
      print("error getting the location");
    }
  }

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
    final report = ref.watch(reportNotifierProvider);
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

          //*Calling the widget
          PhotoEvidenceWidget(),

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
                value: report.category.isEmpty ? null : report.category,

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
                  ref
                      .read(reportNotifierProvider.notifier)
                      .updateCategory((val ?? ''));
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
            onChanged: (value) {
              ref
                  .read(reportNotifierProvider.notifier)
                  .updateDescription(value);
            },
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
                child: PrimaryButtonWidget(
                  buttonOnPress: () {},
                  buttonLabel: report.location != null
                      ? locationController.text
                      : "Enter address or intersection",
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
                  icon: const Icon(
                    Icons.location_on,
                    color: ColorConstants.whiteColor,
                  ),
                  onPressed: () {
                    getCurrentPostion();
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
              fontWeight: FontWeight.w500,
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

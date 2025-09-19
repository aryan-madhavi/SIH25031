import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';

import 'package:civic_reporter/App/presentation/IssueReportingPage/Screens/submit_report_form.dart';
import 'package:flutter/material.dart';

class IssueReportingScreen extends StatelessWidget {
  const IssueReportingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);
    return Scaffold(
      appBar: AppbarWidget('Report Issue', Icons.menu, true, () {}),
      // bottomNavigationBar: BottomNavBar(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(ResponsiveService.w(0.05)),
        child: SecondaryButtonWidget(
          buttonOnPress: () {
            //TODO Submit the Report and Store It in FireStore
          },
          buttonLabel: 'Submit Report',
          buttonIcon: Icons.keyboard_arrow_right_rounded,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveService.w(0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                StringConstants.submitNewReportTitle,
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.1),
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: ResponsiveService.h(0.02)),

              Text(
                "Provide details about the civic issue you'd like to report...",
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.045),
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.darkGreyColor,
                ),
              ),

              SizedBox(height: ResponsiveService.h(0.02)),

              //*report widget
              SubmitReportForm(),
            ],
          ),
        ),
      ),
    );
  }
}

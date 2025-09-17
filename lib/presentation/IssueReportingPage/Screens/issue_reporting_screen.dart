import 'package:civic_reporter/Core/Constants/color_constants.dart';
import 'package:civic_reporter/Core/Constants/string_constants.dart';
import 'package:civic_reporter/Core/services/responsive_service.dart';
import 'package:civic_reporter/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/presentation/IssueReportingPage/widgets/submit_report_form.dart';
import 'package:flutter/material.dart';

class IssueReportingScreen extends StatelessWidget {
  const IssueReportingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveService.w(0.025)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*title
              Text(
                StringConstants.reportButtonText,
                style: TextStyle(color: ColorConstants.primaryColorDark),
              ),
              //*subtitle
              Text(StringConstants.reportIssuePageSubtitle, style: TextStyle()),

              //*report widget
              SubmitReportForm(),
            ],
          ),
        ),
      ),
    );
  }
}

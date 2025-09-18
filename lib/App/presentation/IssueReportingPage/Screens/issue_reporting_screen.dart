import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
// import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
// import 'package:civic_reporter/App/Core/widgets/bottom_nav_bar_widget.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/widgets/submit_report_form.dart';
import 'package:flutter/material.dart';

class IssueReportingScreen extends StatelessWidget {
  const IssueReportingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);
    return Scaffold(
      // appBar: AppbarWidget(),
      // bottomNavigationBar: BottomNavBar(),
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

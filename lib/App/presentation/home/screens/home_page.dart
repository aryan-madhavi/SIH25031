import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/primary_button_widget.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/Screens/issue_reporting_screen.dart';
import 'package:civic_reporter/App/presentation/home/widgets/home_report_information.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);

    return Scaffold(
      appBar: AppbarWidget('CivicReporter', Icons.menu, false, () {}), 
      //bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveService.w(0.025)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstants.Identify,
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.08),
                  color: ColorConstants.primaryColorDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                StringConstants.Prioritize,
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.08),
                  color: ColorConstants.greenColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                StringConstants.Resolve,
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.08),

                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: ResponsiveService.h(0.025)),
              Text(
                StringConstants.AppDiscription,
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.05),
                  color: ColorConstants.darkGreyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: ResponsiveService.h(0.03)),

              SecondaryButtonWidget(
                buttonOnPress: () {
                  //Navigator.pushNamed(context, AppRoutes.issueReportingPage);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IssueReportingScreen(),
                    ),
                  );
                },

                buttonLabel: StringConstants.reportButtonText,
                buttonIcon: Icons.keyboard_arrow_right_rounded,
              ),

              SizedBox(height: ResponsiveService.h(0.03)),

              PrimaryButtonWidget(
                buttonOnPress: () {},
                buttonLabel: "View DashBoard",
              ),

              SizedBox(height: ResponsiveService.h(0.03)),

              HomeReportInformation(),

              SizedBox(height: ResponsiveService.h(0.1)),
            ],
          ),
        ),
      ),
    );
  }
}

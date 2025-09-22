import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';
import 'package:civic_reporter/App/data/repository/report_repository.dart';
import 'package:civic_reporter/App/data/services/storage_services.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/Screens/submit_report_form.dart';
import 'package:civic_reporter/App/providers/report_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IssueReportingScreen extends ConsumerWidget {
  const IssueReportingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportNotifierProvider);
    final reportRepo = ref.watch(reportRepositoryProvider);
    final storageServices = ref.watch(storageServiceProvider);

    ResponsiveService.init(context);
    return Scaffold(
      appBar: AppbarWidget(
        'Report Issue',
        Icons.menu,
        true,
        () => Navigator.pop(context),
      ),

      // bottomNavigationBar: BottomNavBar(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(ResponsiveService.w(0.05)),
        child: FutureSecondaryButtonWidget(
          buttonOnPress: report.isLoading
              ? () async {
                  CircularProgressIndicator();
                }
              : () async {
                  try {
                    await ref
                        .read(reportNotifierProvider.notifier)
                        .submitReport(
                          reportRepo: reportRepo,
                          storageService: storageServices,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Report submitted successfully!"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Submission failed: $e")),
                    );
                  }
                },
          buttonLabel: report.isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  'Submit Report',
                  style: TextStyle(
                    fontSize: ResponsiveService.fs(0.040),
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.whiteColor,
                  ),
                ),
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

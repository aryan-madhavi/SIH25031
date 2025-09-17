import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/presentation/home/widgets/home_report_widget.dart';
import 'package:flutter/material.dart';

class HomeReportInformation extends StatelessWidget {
  const HomeReportInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final List HomeReportList = [
      {
        'icon': Icons.location_on_outlined,
        'title': StringConstants.issuesReported,
        'subtitle': "12,847",
      },
      {
        'icon': Icons.timer_outlined,
        'title': StringConstants.avgResponseTime,
        'subtitle': "24hr",
      },
      {
        'icon': Icons.person_outline_outlined,
        'title': StringConstants.activeCommunity,
        'subtitle': "156",
      },
      {
        'icon': Icons.timeline_outlined,
        'title': StringConstants.resolutionRate,
        'subtitle': "89%",
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        mainAxisSpacing: 15.0, // vertical space between items
        crossAxisSpacing: 10.0, // horizontal space between items
        childAspectRatio: ResponsiveService.w(0.003), // width : height ratio
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = HomeReportList[index];

        return HomeReportWidget(item['icon'], item['title'], item['subtitle']);
      },
      itemCount: HomeReportList.length,
    );
  }
}

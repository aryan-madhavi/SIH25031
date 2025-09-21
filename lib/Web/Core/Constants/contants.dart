import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
// import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/Web/presentation/administration/screen/administration_page.dart';
import 'package:civic_reporter/Web/presentation/audit%20logs/screen/audit_logs_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/screens/dashboard_page.dart';
import 'package:civic_reporter/Web/presentation/people/screen/people_page.dart';
import 'package:civic_reporter/Web/presentation/reports/screen/reports_page.dart';
import 'package:flutter/material.dart';

// TODO: fetch firebase data and store it into constants

class ConstantsofSideBar{
  // static int pageno = 0;
  // static bool isExpanded = false;
  static final List<String> labels = const [
    "Dashboard",
    "Reports",
    "People",
    "Logs",
    "Administration",
  ];

  static final List<IconData> icons = const [
    Icons.dashboard,
    Icons.report_sharp,
    Icons.group,
    Icons.login,
    Icons.admin_panel_settings,
  ];

  static final List<Widget> pages = const [
    DashboardPage(),
    ReportsPage(),
    PeoplePage(),
    AuditLogsPage(),
    AdministrationPage(),
  ];

  static final Shader linearGradient = LinearGradient(
      colors: <Color>[
        ColorConstants.primaryColorLight,
        ColorConstants.primaryColorDark,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

}


class Constantsofdashboard{
  static final List<String> titles = const [
    'TOTAL REPORTS TODAY',
    'OPEN ISSUES',
    'RESOLVED TODAY',
    'AVG RESOLUTION TIME',
  ];
  static final List<String> values = const ['247', '89', '156', '2.4 days'];
  static final List<String> comparisons = const [
    '+12% vs yesterday',
    '-5% vs yesterday',
    '+18% vs yesterday',
    '-0.3d vs yesterday',
  ];
  static final List<IconData> icons = const [
    Icons.description,
    Icons.warning_amber,
    Icons.check_circle,
    Icons.timer,
  ];
  static final List<Color> colors = const [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
  ];
}
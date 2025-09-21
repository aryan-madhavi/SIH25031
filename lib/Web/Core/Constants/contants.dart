import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Constants/string_constants.dart';
import 'package:civic_reporter/Web/presentation/administration/screen/administration_page.dart';
import 'package:civic_reporter/Web/presentation/audit%20logs/screen/audit_logs_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/screens/dashboard_page.dart';
import 'package:civic_reporter/Web/presentation/people/screen/people_page.dart';
import 'package:civic_reporter/Web/presentation/reports/screen/reports_page.dart';
import 'package:flutter/material.dart';

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
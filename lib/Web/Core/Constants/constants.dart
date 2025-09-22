import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/Web/presentation/administration/screen/administration_page.dart';
import 'package:civic_reporter/Web/presentation/audit%20logs/screen/audit_logs_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/screens/dashboard_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/widgets/pie_chart_card.dart';
import 'package:civic_reporter/Web/presentation/people/screen/people_page.dart';
import 'package:civic_reporter/Web/presentation/reports/screen/reports_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

//Sidebar
class ConstantsofSideBar {
  static final pageIndexProvider = StateProvider<int>((ref) => 0);

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

  static final List<Widget> pages = [
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

//Dashboard: Start
//Grid Metric
class ConstantsOfDashboardGridMetric {
  static final List<String> values = const ['247', '89', '156', '2.4 days'];

  static final List<String> titles = const [
    'TOTAL REPORTS TODAY',
    'OPEN ISSUES',
    'RESOLVED TODAY',
    'AVG RESOLUTION TIME',
  ];

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

//Report Issue
class ConstantsOfDashboardReportIssue {
  static final List<String> ids = const [
    'CC-2024-0001',
    'CC-2024-0002',
    'CC-2024-0003',
  ];

  static final List<String> titles = const [
    'Road Repair',
    'Street Light',
    'Water Leakage',
  ];

  static final List<String> locations = const [
    'MG Road, Sector 14',
    'Park Street, Ward 3',
    'Housing Colony, Block A',
  ];

  static final List<String> departments = const [
    'PWD',
    'Electricity',
    'Water Works',
  ];

  static final List<String> timesAgo = const [
    '2 hours ago',
    '4 hours ago',
    '1 hour ago',
  ];

  static final List<Status> statuses = const [
    Status.Assigned,
    Status.InProgress,
    Status.New,
  ];

  static final List<Priority> priorities = const [
    Priority.High,
    Priority.Medium,
    Priority.Low,
  ];
}

//Stacked Column Chart
class ConstantsOfDashboardStackedColumnChart {
  final String category;
  final int pending;
  final int successful;

  ConstantsOfDashboardStackedColumnChart(
    this.category,
    this.pending,
    this.successful,
  );

  static final choiceProvider = StateProvider<String>((ref) => "Yearly");

  static final List<ConstantsOfDashboardStackedColumnChart> yearlyData = [
    ConstantsOfDashboardStackedColumnChart("2021", 30, 60),
    ConstantsOfDashboardStackedColumnChart("2022", 40, 70),
    ConstantsOfDashboardStackedColumnChart("2023", 20, 50),
    ConstantsOfDashboardStackedColumnChart("2024", 50, 20),
    ConstantsOfDashboardStackedColumnChart("2025", 30, 40),
    ConstantsOfDashboardStackedColumnChart("2026", 10, 70),
  ];

  static final List<ConstantsOfDashboardStackedColumnChart> monthlyData = [
    ConstantsOfDashboardStackedColumnChart("Jan-2025", 10, 15),
    ConstantsOfDashboardStackedColumnChart("Feb-2025", 20, 25),
    ConstantsOfDashboardStackedColumnChart("Mar-2025", 15, 30),
  ];

  static final List<ConstantsOfDashboardStackedColumnChart> dailyData = [
    ConstantsOfDashboardStackedColumnChart("01-09-2025", 5, 10),
    ConstantsOfDashboardStackedColumnChart("02-09-2025", 7, 12),
    ConstantsOfDashboardStackedColumnChart("03-09-2025", 8, 14),
  ];

  static final List<ConstantsOfDashboardStackedColumnChart> deptData = [
    ConstantsOfDashboardStackedColumnChart("Dept1", 15, 20),
    ConstantsOfDashboardStackedColumnChart("Dept2", 10, 30),
    ConstantsOfDashboardStackedColumnChart("Dept3", 25, 15),
  ];

  static final List<DropdownMenuItem> options = [
    DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
    DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
    DropdownMenuItem(value: "Daily", child: Text("Daily")),
    DropdownMenuItem(value: "Departments", child: Text("Departments")),
  ];

  static List<ConstantsOfDashboardStackedColumnChart> chartData(String choice) {
    switch (choice) {
      case "Monthly":
        return monthlyData;
      case "Daily":
        return dailyData;
      case "Departments":
        return deptData;
      default:
        return yearlyData;
    }
  }
}

//Pie Chart
class ConstantsOfDashboardPieChart {
  static final List<ChartData> chartdata =[
    ChartData("Dept1",10),
    ChartData("Dept2",5),
    ChartData("Dept3",20),
    ChartData("Dept4",11),
    ChartData("Dept5",12),
    ChartData("Dept6",15),

  ];
}
//Dashboard: End

//Enums
enum Priority { High, Medium, Low }

enum Status { New, Assigned, InProgress, Resolved }

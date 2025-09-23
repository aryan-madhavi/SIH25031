import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/Web/presentation/administration/screen/administration_page.dart';
import 'package:civic_reporter/Web/presentation/audit%20logs/screen/audit_logs_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/screens/dashboard_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/widgets/pie_chart_card.dart';
import 'package:civic_reporter/Web/presentation/people/screen/people_page.dart';
import 'package:civic_reporter/Web/presentation/reports/screen/reports_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

enum Priority { High, Medium, Low }
enum Status { New, Assigned, InProgress, Resolved }

class User {
  final String id;
  final String name;
  final String department;
  const User({required this.id, required this.name, required this.department});
}

class Report {
  final String id;
  final String category;
  final String location;
  final String citizenName;
  final String citizenPhone;
  final Priority priority;
  final Status status;
  final String department;
  final DateTime submittedDate;
  final DateTime lastUpdated;
  final User? assignedTo;

  Report({
    required this.id,
    required this.category,
    required this.location,
    required this.citizenName,
    required this.citizenPhone,
    required this.priority,
    required this.status,
    required this.department,
    required this.submittedDate,
    required this.lastUpdated,
    this.assignedTo,
  });

  Report copyWith({Status? status, DateTime? lastUpdated, User? assignedTo}) {
    return Report(
      id: id, category: category, location: location, citizenName: citizenName,
      citizenPhone: citizenPhone, priority: priority, status: status ?? this.status,
      department: department, submittedDate: submittedDate,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      assignedTo: assignedTo ?? this.assignedTo,
    );
  }
}

final pageIndexProvider = StateProvider<int>((ref) => 0);

final stackedChartChoiceProvider = StateProvider<String>((ref) => "Yearly");

class ConstantsofSideBar {
  static final List<String> labels = ["Dashboard", "Reports", "People", "Logs", "Administration"];
  static final List<IconData> icons = [Icons.dashboard, Icons.report_sharp, Icons.group, Icons.login, Icons.admin_panel_settings];
  static final List<Widget> pages = [DashboardPage(), ReportsPage(), PeoplePage(), AuditLogsPage(), AdministrationPage()];
  static final Shader linearGradient = LinearGradient(colors: <Color>[ColorConstants.primaryColorLight, ColorConstants.primaryColorDark]).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}

class ConstantsOfDashboardGridMetric {
  static final List<String> values = const ['247', '89', '156', '2.4 days'];
  static final List<String> titles = const ['TOTAL REPORTS TODAY', 'OPEN ISSUES', 'RESOLVED TODAY', 'AVG RESOLUTION TIME'];
  static final List<String> comparisons = const ['+12% vs yesterday', '-5% vs yesterday', '+18% vs yesterday', '-0.3d vs yesterday'];
  static final List<IconData> icons = const [Icons.description, Icons.warning_amber, Icons.check_circle, Icons.timer];
  static final List<Color> colors = const [Colors.blue, Colors.orange, Colors.green, Colors.purple];
}

class ConstantsOfReports {
  static const User sampleUser = User(id: 'user-01', name: 'Suresh Sharma', department: 'PWD');
  static final List<Report> initialReports = const [];
}

class ConstantsOfDashboardStackedColumnChart {
  final String category;
  final int pending;
  final int successful;

  ConstantsOfDashboardStackedColumnChart(this.category, this.pending, this.successful);
  static final List<ConstantsOfDashboardStackedColumnChart> yearlyData = [ConstantsOfDashboardStackedColumnChart("2021", 30, 60)];
  static final List<ConstantsOfDashboardStackedColumnChart> monthlyData = [ConstantsOfDashboardStackedColumnChart("Jan-2025", 10, 15)];
  static final List<ConstantsOfDashboardStackedColumnChart> dailyData = [ConstantsOfDashboardStackedColumnChart("01-09-2025", 5, 10)];
  static final List<ConstantsOfDashboardStackedColumnChart> deptData = [ConstantsOfDashboardStackedColumnChart("Dept1", 15, 20)];
  static final List<DropdownMenuItem> options = [
     const DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
     const DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
     const DropdownMenuItem(value: "Daily", child: Text("Daily")),
     const DropdownMenuItem(value: "Departments", child: Text("Departments")),
  ];
  static List<ConstantsOfDashboardStackedColumnChart> chartData(String choice) {
    switch (choice) {
      case "Monthly": return monthlyData;
      case "Daily": return dailyData;
      case "Departments": return deptData;
      default: return yearlyData;
    }
  }
}

class ConstantsOfDashboardPieChart {
  static final List<ChartData> chartdata = [ChartData("Dept1",10)];
}
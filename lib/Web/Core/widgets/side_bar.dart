import 'package:civic_reporter/Web/presentation/administration/screen/administration_page.dart';
import 'package:civic_reporter/Web/presentation/audit%20logs/screen/audit_logs_page.dart';
import 'package:civic_reporter/Web/presentation/dashboard/screens/dashboard_page.dart';
import 'package:civic_reporter/Web/presentation/people/screen/people_page.dart';
import 'package:civic_reporter/Web/presentation/reports/screen/reports_page.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int pageno=0;

  final List<String> _labels = const [
    "Dashboard",
    "Reports",
    "People",
    "Logs",
    "Administration",
  ];

  final List<Icon> _icons = const [
    Icon(Icons.dashboard),
    Icon(Icons.report_sharp),
    Icon(Icons.group),
    Icon(Icons.login),
    Icon(Icons.admin_panel_settings),
  ];

  final List<Widget> _pages = const [
    DashboardPage(),
    ReportsPage(),
    PeoplePage(),
    AuditLogsPage(),
    AdministrationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          NavigationRail(
            selectedIndex: pageno, 
            onDestinationSelected: (int pageIndex) {setState(() {
              pageno = pageIndex;
            });
            } ,
            destinations: List.generate(_labels.length, (index) {
              return NavigationRailDestination(icon: _icons[index], label: Text(_labels[index]),);
            },),),
            Expanded(child: _pages[pageno]),
        ],
    );
  }
}
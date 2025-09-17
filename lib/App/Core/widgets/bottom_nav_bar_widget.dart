import 'package:civic_reporter/App/presentation/IssueReportingPage/Screens/issue_reporting_screen.dart';
import 'package:civic_reporter/App/presentation/ReportHistory/Screens/report_history_page.dart';
import 'package:civic_reporter/App/presentation/TrackYourReport/Screens/track_your_report_page.dart';
import 'package:civic_reporter/App/presentation/UserProfile/Screens/user_profile_page.dart';
import 'package:civic_reporter/App/presentation/home/screens/home_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int page_no = 0;
  final List<Widget> _pages = const [
    HomePage(),
    IssueReportingScreen(),
    TrackYourReportPage(),
    ReportHistoryPage(),
    UserProfilePage(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[page_no],
      bottomNavigationBar: NavigationBar(
        selectedIndex: page_no,
        onDestinationSelected: (int pageIndex) {
          setState(() {
            page_no = pageIndex;
          });
        },

        destinations: const <Widget>[
          // Home
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),

          // Issue Report
          NavigationDestination(
            icon: Icon(Icons.report),
            label: "Report",
          ),

          // Track Your Report
          NavigationDestination(
            icon: Icon(Icons.menu_book_sharp),
            label: "Tack",
          ),

          // Report History
          NavigationDestination(
            icon: Icon(Icons.history),
            label: "History",
          ),

          // User Profile
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ],
      ),
    );
  }
}

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
  int pageno = 0;

  final List<String> _labels = const [
    "Home",
    // "Report",
    "Track",
    "History",
    "Profile",
  ];

  final List<Icon> _icons = const [
    Icon(Icons.home),
    // Icon(Icons.report),
    Icon(Icons.menu_book_sharp),
    Icon(Icons.history),
    Icon(Icons.person),
  ];

  final List<Widget> _pages = [
    HomePage(),
    // IssueReportingScreen(),
    TrackYourReportPage(),
    ReportHistoryPage(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[pageno],
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageno,
        onDestinationSelected: (int pageIndex) {
          setState(() {
            pageno = pageIndex;
          });
        },

        destinations: List.generate(_labels.length, (index) {
          return NavigationDestination(
            icon: _icons[index],
            label: _labels[index],
          );
        }),

        // destinations: const <Widget>[
        //   // Home
        //   NavigationDestination(
        //     icon: _icon,
        //     label: "Home",
        //     ),

        //   // Issue Report
        //   NavigationDestination(
        //     icon: Icon(Icons.report),
        //     label: "Report",
        //   ),

        //   // Track Your Report
        //   NavigationDestination(
        //     icon: Icon(Icons.menu_book_sharp),
        //     label: "Tack",
        //   ),

        //   // Report History
        //   NavigationDestination(
        //     icon: Icon(Icons.history),
        //     label: "History",
        //   ),

        //   // User Profile
        //   NavigationDestination(
        //     icon: Icon(Icons.person),
        //     label: "Profile",
        //   ),
        // ],
      ),
    );
  }
}

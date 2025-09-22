import 'package:civic_reporter/App/Core/widgets/bottom_nav_bar_widget.dart';
import 'package:civic_reporter/App/presentation/IssueReportingPage/Screens/issue_reporting_screen.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/Screens/login_page.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/Screens/signup_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/home';
  static const String loginPage = '/loginPage';
  static const String signupPage = '/signupPage';
  static const String issueReportingPage = '/issueReportingPage';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const BottomNavBar(),
    loginPage: (context) => const LoginPage(),
    signupPage: (context) => const SignupPage(),
    issueReportingPage: (context) => const IssueReportingScreen(),
  };
}

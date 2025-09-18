import 'package:civic_reporter/App/Core/Theme/dark_theme.dart';
import 'package:civic_reporter/App/Core/Theme/light_theme.dart';
import 'package:civic_reporter/App/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/bottom_nav_bar_widget.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/Screens/login_page.dart';
import 'package:civic_reporter/Web/Core/widgets/side_bar.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:civic_reporter/App/Core/widgets/bottom_nav_bar_widget.dart';
// import 'package:civic_reporter/presentation/IssueReportingPage/Screens/issue_reporting_screen.dart';
// import 'package:civic_reporter/App/presentation/home/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        return MaterialApp(
          title: 'Civic Reporter',

          theme: lightThemeData,
          darkTheme: darkThemeData,
          debugShowCheckedModeBanner: false,
          // home: const RootScaffold(),
          home: LoginPage(),
          themeMode: themeMode,
        );
      },
    );
  }
}

class RootScaffold extends StatelessWidget {
  const RootScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? null
          : const AppbarWidget('CivicReporter', Icons.menu, false),
      body: kIsWeb ? const SideBar() : const BottomNavBar(),
    );
  }
}

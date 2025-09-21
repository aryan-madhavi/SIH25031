import 'package:civic_reporter/Web/presentation/dashboard/widgets/dashboard_metric_grid_card.dart';
import 'package:civic_reporter/Web/presentation/dashboard/widgets/pie_chart_card.dart';
import 'package:civic_reporter/Web/presentation/dashboard/widgets/recent_reports_card.dart';
import 'package:civic_reporter/Web/presentation/dashboard/widgets/stacked_column_chart_card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StackedColumnChartCard(),
              PieChartCard(),
              DashboardMetricGridCard(),
              RecentReportsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
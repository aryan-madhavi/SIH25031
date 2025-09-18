import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:riverpod/legacy.dart';

class StackedColumnChartCard extends ConsumerStatefulWidget {
  const StackedColumnChartCard({super.key});

  @override
  ConsumerState<StackedColumnChartCard> createState() => _StackedColumnChartCardState();
}

class _StackedColumnChartCardState extends ConsumerState<StackedColumnChartCard> {
  @override
  Widget build(BuildContext context) {
    final choice = ref.watch(choiceProvider);
    return Card(
      margin: EdgeInsets.all(30),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: Column(
        children: [
          DropdownButton(
              value: choice,
              items: options,
              onChanged: (val){
                if (val !=null)
                {ref.read(choiceProvider.notifier).state = val;}
                },
            ),

          SizedBox(height: 10),

          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: SfCartesianChart(
              title: ChartTitle(text: "Report Status: $choice"),
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0),
              series: <StackedColumnSeries>[
                StackedColumnSeries<ReportStatus, String>(
                  dataSource: chartData(choice),
                  xValueMapper: (ReportStatus data, _) => data.category,
                  yValueMapper: (ReportStatus data, _) => data.pending,
                  name: "Pending",
                  // opacity: 1,
                ),
                StackedColumnSeries<ReportStatus, String>(
                  dataSource: chartData(choice),
                  xValueMapper: (ReportStatus data, _) => data.category,
                  yValueMapper: (ReportStatus data, _) => data.successful,
                  name: "Successful",
                  // opacity: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//TODO: Add into new page and connect firestore db

class ReportStatus {
  final String category;
  final int pending;
  final int successful;

  ReportStatus(this.category, this.pending, this.successful);
}

final choiceProvider = StateProvider<String>((ref)=>"Yearly");

final List<ReportStatus> yearlyData = [
  ReportStatus("2021", 30, 60),
  ReportStatus("2022", 40, 70),
  ReportStatus("2023", 20, 50),
  ReportStatus("2024", 50, 20),
  ReportStatus("2025", 30, 40),
  ReportStatus("2026", 10, 70),

];

final List<ReportStatus> monthlyData = [
  ReportStatus("Jan-2025", 10, 15),
  ReportStatus("Feb-2025", 20, 25),
  ReportStatus("Mar-2025", 15, 30),
];

final List<ReportStatus> dailyData = [
  ReportStatus("01-09-2025", 5, 10),
  ReportStatus("02-09-2025", 7, 12),
  ReportStatus("03-09-2025", 8, 14),
];

final List<ReportStatus> deptData = [
  ReportStatus("Dept1", 15, 20),
  ReportStatus("Dept2", 10, 30),
  ReportStatus("Dept3", 25, 15),
];

final List<DropdownMenuItem> options = [
  DropdownMenuItem(value: "Yearly", child: Text("Yearly")),
  DropdownMenuItem(value: "Monthly", child: Text("Monthly")),
  DropdownMenuItem(value: "Daily", child: Text("Daily")),
  DropdownMenuItem(value: "Departments", child: Text("Departments")),
];

List<ReportStatus> chartData (String choice){
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

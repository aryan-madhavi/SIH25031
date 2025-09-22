import 'package:civic_reporter/Web/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedColumnChartCard extends ConsumerStatefulWidget {
  const StackedColumnChartCard({super.key});

  @override
  ConsumerState<StackedColumnChartCard> createState() =>
      _StackedColumnChartCardState();
}

class _StackedColumnChartCardState
    extends ConsumerState<StackedColumnChartCard> {
  @override
  Widget build(BuildContext context) {
    final choice = ref.watch(ConstantsOfDashboardStackedColumnChart.choiceProvider);
    return Card(
      margin: EdgeInsets.all(30),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Report Status", style: TextStyle(
                  fontSize: 25,
                ),),
                DropdownButton(
                  padding: EdgeInsets.fromLTRB(15,0,15,0),
                  borderRadius: BorderRadius.circular(50),
                  icon: Icon(Icons.filter_alt),
                  value: choice,
                  iconSize: 22,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  items: ConstantsOfDashboardStackedColumnChart.options,
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(ConstantsOfDashboardStackedColumnChart.choiceProvider.notifier).state = val;
                    }
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: SfCartesianChart(
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0),
              series: <StackedColumnSeries>[
                StackedColumnSeries<ConstantsOfDashboardStackedColumnChart, String>(
                  dataSource: ConstantsOfDashboardStackedColumnChart.chartData(choice),
                  xValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) => data.category,
                  yValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) => data.pending,
                  name: "Pending",
                ),
                StackedColumnSeries<ConstantsOfDashboardStackedColumnChart, String>(
                  dataSource: ConstantsOfDashboardStackedColumnChart.chartData(choice),
                  xValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) => data.category,
                  yValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) => data.successful,
                  name: "Successful",
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


import 'package:civic_reporter/Web/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedColumnChartCard extends ConsumerWidget {
  const StackedColumnChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choice = ref.watch(stackedChartChoiceProvider);
    return Card(
      margin: const EdgeInsets.all(30),
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
                const Text(
                  "Report Status",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                DropdownButton(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  borderRadius: BorderRadius.circular(50),
                  icon: const Icon(Icons.filter_alt),
                  value: choice,
                  iconSize: 22,
                  style: Theme.of(context).textTheme.titleLarge, // Using theme for safety
                  items: ConstantsOfDashboardStackedColumnChart.options,
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(stackedChartChoiceProvider.notifier).state = val;
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SfCartesianChart(
              legend: const Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
              ),
              primaryXAxis: const CategoryAxis(),
              primaryYAxis: const NumericAxis(minimum: 0),
              series: <StackedColumnSeries>[
                StackedColumnSeries<ConstantsOfDashboardStackedColumnChart, String>(
                  dataSource: ConstantsOfDashboardStackedColumnChart.chartData(choice),
                  xValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) =>
                      data.category,
                  yValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) =>
                      data.pending,
                  name: "Pending",
                ),
                StackedColumnSeries<ConstantsOfDashboardStackedColumnChart, String>(
                  dataSource: ConstantsOfDashboardStackedColumnChart.chartData(choice),
                  xValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) =>
                      data.category,
                  yValueMapper: (ConstantsOfDashboardStackedColumnChart data, _) =>
                      data.successful,
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
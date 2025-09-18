import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PieChartCard extends StatefulWidget {
  const PieChartCard({super.key});

  @override
  State<PieChartCard> createState() => _PieChartCardState();
}

class _PieChartCardState extends State<PieChartCard> {
  final List<ChartData> chartdata =[
    ChartData("Title1",10),
    ChartData("Title2",5),
    ChartData("Title3",20),
    ChartData("Title4",11),
    ChartData("Title5",12),
    ChartData("Title6",15),

  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(30),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SfCircularChart(
          title: ChartTitle(text: "Dept Wise Report"),
          legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        series: <CircularSeries>[
            PieSeries<ChartData,String>(
              dataSource: chartdata,
              xValueMapper: (ChartData data, _) => data.category,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelMapper: (ChartData data, _)=> '${data.category}:${data.value}',
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              explode: true,
              explodeIndex: 0,
            )
          ],

        ),
      ),
    );
  }
}


class ChartData{
  final String category;
  final double value;

  ChartData(this.category,this.value);
}
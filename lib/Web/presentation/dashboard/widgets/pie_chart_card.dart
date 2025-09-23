import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PieChartCard extends ConsumerWidget {
  const PieChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsStream = FirebaseFirestore.instance.collection('reports').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: reportsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];
        final Map<String, int> counts = {};
        for (final d in docs) {
          final data = d.data() as Map<String, dynamic>;
          final dept = (data['category'] ?? 'Unknown').toString();
          counts[dept] = (counts[dept] ?? 0) + 1;
        }

        final chartData = counts.entries.map((e) => ChartData(e.key, e.value.toDouble())).toList();

        return Card(
          margin: const EdgeInsets.all(30),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Total Number Of Report Per Department",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SfCircularChart(
                  legend: const Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.category,
                      yValueMapper: (ChartData data, _) => data.value,
                      dataLabelMapper: (ChartData data, _) => '${data.value.toInt()}',
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                      explode: true,
                      explodeIndex: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}
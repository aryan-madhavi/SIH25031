import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StackedColumnChartCard extends ConsumerStatefulWidget {
  const StackedColumnChartCard({super.key});

  @override
  ConsumerState<StackedColumnChartCard> createState() => _StackedColumnChartCardState();
}

class _StackedColumnChartCardState extends ConsumerState<StackedColumnChartCard> {
  String choice = 'Yearly';
  List<StackedData> _aggregate(List<QueryDocumentSnapshot> docs, String choice) {
    String bucketKeyForTimestamp(Timestamp ts) {
      final dt = ts.toDate();
      if (choice == 'Daily') return '${dt.year}-${dt.month}-${dt.day}';
      if (choice == 'Monthly') return '${dt.year}-${dt.month}';
      return '${dt.year}';
    }

    final Map<String, Map<String, int>> buckets = {};

    for (final d in docs) {
      final data = d.data() as Map<String, dynamic>;
      final status = (data['status'] ?? '').toString().toLowerCase();
      String bucket;
      if (choice == 'Departments') {
        bucket = (data['category'] ?? 'Unknown').toString();
      } else {
        final ts = data['timestamp'];
        if (ts is Timestamp) {
          bucket = bucketKeyForTimestamp(ts);
        } else if (ts is Map && ts['seconds'] != null) {
          bucket = bucketKeyForTimestamp(Timestamp(ts['seconds'], ts['nanoseconds'] ?? 0));
        } else {
          bucket = 'Unknown';
        }
      }

      buckets.putIfAbsent(bucket, () => {'pending': 0, 'successful': 0});

      if (status.contains('resolved') || status.contains('successful') || status.contains('done')) {
        buckets[bucket]!['successful'] = buckets[bucket]!['successful']! + 1;
      } else {
        buckets[bucket]!['pending'] = buckets[bucket]!['pending']! + 1;
      }
    }

    final entries = buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return entries
        .map((e) => StackedData(e.key, (e.value['pending'] ?? 0).toDouble(), (e.value['successful'] ?? 0).toDouble()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
  // use local state 'choice'
    final stream = FirebaseFirestore.instance.collection('reports').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];
        final data = _aggregate(docs, choice);

        return Card(
          margin: const EdgeInsets.all(30),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      style: Theme.of(context).textTheme.titleLarge,
                      items: const ["Yearly", "Monthly", "Daily", "Departments"].map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            choice = val;
                          });
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
                    StackedColumnSeries<StackedData, String>(
                      dataSource: data,
                      xValueMapper: (StackedData d, _) => d.category,
                      yValueMapper: (StackedData d, _) => d.pending,
                      name: "Pending",
                    ),
                    StackedColumnSeries<StackedData, String>(
                      dataSource: data,
                      xValueMapper: (StackedData d, _) => d.category,
                      yValueMapper: (StackedData d, _) => d.successful,
                      name: "Successful",
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

class StackedData {
  final String category;
  final double pending;
  final double successful;

  StackedData(this.category, this.pending, this.successful);
}
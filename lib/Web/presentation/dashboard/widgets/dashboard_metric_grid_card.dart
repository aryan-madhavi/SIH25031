import 'package:civic_reporter/Web/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String comparison;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.comparison,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  comparison,
                  style: const TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardMetricGridCard extends StatelessWidget {
  const DashboardMetricGridCard({super.key});

  int _getCrossAxisCount(int itemCount) {
    if (itemCount <= 4) return 2;
    if (itemCount <= 6) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    final reportsStream = FirebaseFirestore.instance.collection('reports').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: reportsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ConstantsOfDashboardGridMetric.titles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(ConstantsOfDashboardGridMetric.titles.length),
              childAspectRatio: 2.5,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
            ),
            itemBuilder: (context, index) {
              return MetricCard(
                title: ConstantsOfDashboardGridMetric.titles[index],
                value: "-",
                comparison: ConstantsOfDashboardGridMetric.comparisons[index],
                icon: ConstantsOfDashboardGridMetric.icons[index],
                color: ConstantsOfDashboardGridMetric.colors[index],
              );
            },
          );
        }

        final docs = snapshot.data?.docs ?? [];

        final now = DateTime.now();
        final todayStart = DateTime(now.year, now.month, now.day);
        final todayEnd = todayStart.add(const Duration(days: 1));

        int totalToday = 0;
        int openIssues = 0;
        int resolvedToday = 0;
        double totalResolutionHours = 0;
        int resolvedCountForAvg = 0;

        DateTime? parseTimestamp(dynamic raw) {
          try {
            if (raw == null) return null;
            if (raw is Timestamp) return raw.toDate();
            if (raw is DateTime) return raw;
            if (raw is int) return DateTime.fromMillisecondsSinceEpoch(raw);
            if (raw is String) return DateTime.tryParse(raw);
            if (raw is Map) {
              final seconds = raw['seconds'] ?? raw['_seconds'];
              final nanos = raw['nanoseconds'] ?? raw['_nanoseconds'] ?? 0;
              if (seconds != null) {
                return Timestamp(seconds, nanos).toDate();
              }
            }
          } catch (_) {}
          return null;
        }

        for (final d in docs) {
          final data = d.data() as Map<String, dynamic>;
          final created = parseTimestamp(data['timestamp']);
          final status = (data['status'] ?? '').toString().toLowerCase();

          if (created != null) {
            final createdLocal = created.toLocal();
            if (!createdLocal.isBefore(todayStart) && createdLocal.isBefore(todayEnd)) totalToday++;
          }

          final closed = status.contains('resolved') || status.contains('successful') || status.contains('done');
          if (!closed) openIssues++;

          final resolvedDateRaw = parseTimestamp(data['resolvedTimestamp']);
          if (resolvedDateRaw != null) {
            final resolvedLocal = resolvedDateRaw.toLocal();
            if (!resolvedLocal.isBefore(todayStart) && resolvedLocal.isBefore(todayEnd)) resolvedToday++;
            if (created != null) {
              final createdLocal = created.toLocal();
              totalResolutionHours += resolvedLocal.difference(createdLocal).inMinutes / (60.0 * 24.0);
              resolvedCountForAvg++;
            }
          }
        }

        final avgResolutionDays = resolvedCountForAvg > 0 ? (totalResolutionHours / resolvedCountForAvg) : 0.0;

        final values = [
          totalToday.toString(),
          openIssues.toString(),
          resolvedToday.toString(),
          '${avgResolutionDays.toStringAsFixed(1)} days',
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ConstantsOfDashboardGridMetric.titles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(ConstantsOfDashboardGridMetric.titles.length),
            childAspectRatio: 2.5,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            return MetricCard(
              title: ConstantsOfDashboardGridMetric.titles[index],
              value: values[index],
              comparison: ConstantsOfDashboardGridMetric.comparisons[index],
              icon: ConstantsOfDashboardGridMetric.icons[index],
              color: ConstantsOfDashboardGridMetric.colors[index],
            );
          },
        );
      },
    );
  }
}
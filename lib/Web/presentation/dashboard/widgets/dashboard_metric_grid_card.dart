import 'package:civic_reporter/Web/Core/Constants/contants.dart';
import 'package:flutter/material.dart';

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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Constantsofdashboard.titles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(Constantsofdashboard.titles.length),
        childAspectRatio: 2.5,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        return MetricCard(
          title: Constantsofdashboard.titles[index],
          value: Constantsofdashboard.values[index],
          comparison: Constantsofdashboard.comparisons[index],
          icon: Constantsofdashboard.icons[index],
          color: Constantsofdashboard.colors[index],
        );
      },
    );
  }
}
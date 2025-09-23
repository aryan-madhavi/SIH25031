import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:civic_reporter/Web/Core/Constants/constants.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Issues", style: theme.textTheme.headlineMedium),
            const SizedBox(height: 24),
            Card(
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('Issue ID')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Citizen')),
                    DataColumn(label: Text('Priority')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Assigned To')),
                    DataColumn(label: Text('Submitted')),
                  ],
                  rows: reports.map((report) {
                    return DataRow(
                      onSelectChanged: (_) => _showReportDetailsDialog(context, ref, report),
                      cells: [
                        DataCell(Text(report.id)),
                        DataCell(Text(report.category)),
                        DataCell(Text(report.citizenName)),
                        DataCell(_PriorityTag(priority: report.priority)),
                        DataCell(_StatusTag(status: report.status)),
                        DataCell(Text(report.assignedTo?.name ?? 'Unassigned')),
                        DataCell(Text(DateFormat('M/d/yyyy\nh:mm a').format(report.submittedDate))),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDetailsDialog(BuildContext context, WidgetRef ref, Report report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Report Details: ${report.id}'),
          content: Text('Status: ${report.status.name}\nCategory: ${report.category}\nLocation: ${report.location}'),
          actions: [
            if (report.status == Status.New)
              ElevatedButton(
                onPressed: () {
                  ref.read(reportsProvider.notifier).assignReport(report.id, ConstantsOfReports.sampleUser);
                  Navigator.of(context).pop();
                },
                child: const Text('Assign to User'),
              ),
            if (report.status == Status.Assigned)
              ElevatedButton(
                onPressed: () {
                  ref.read(reportsProvider.notifier).startProgress(report.id);
                  Navigator.of(context).pop();
                },
                child: const Text('Start Progress'),
              ),
            if (report.status == Status.InProgress)
              ElevatedButton(
                onPressed: () {
                  ref.read(reportsProvider.notifier).resolveReport(report.id);
                  Navigator.of(context).pop();
                },
                child: const Text('Mark as Resolved'),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// Helper Widgets for Tags
class _PriorityTag extends StatelessWidget {
  final Priority priority;
  const _PriorityTag({required this.priority});

  @override
  Widget build(BuildContext context) {
    final styles = {
      Priority.High: {'color': Colors.red, 'text': 'High'},
      Priority.Medium: {'color': Colors.orange, 'text': 'Medium'},
      Priority.Low: {'color': Colors.blue, 'text': 'Low'},
    }[priority]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: (styles['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Text(styles['text'] as String, style: TextStyle(color: styles['color'] as Color, fontWeight: FontWeight.bold)),
    );
  }
}

class _StatusTag extends StatelessWidget {
  final Status status;
  const _StatusTag({required this.status});

  @override
  Widget build(BuildContext context) {
    final styles = {
      Status.New: {'color': Colors.red.shade800, 'bgColor': Colors.red.shade100, 'text': 'New'},
      Status.Assigned: {'color': Colors.black, 'bgColor': Colors.grey.shade300, 'text': 'Assigned'},
      Status.InProgress: {'color': Colors.blue.shade800, 'bgColor': Colors.blue.shade100, 'text': 'In Progress'},
      Status.Resolved: {'color': Colors.green.shade800, 'bgColor': Colors.green.shade100, 'text': 'Resolved'},
    }[status]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: styles['bgColor'] as Color, borderRadius: BorderRadius.circular(8)),
      child: Text(styles['text'] as String, style: TextStyle(color: styles['color'] as Color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}
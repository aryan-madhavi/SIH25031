import 'package:civic_reporter/Web/Core/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentReportsCard extends ConsumerWidget {
  const RecentReportsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Issues", style: theme.textTheme.titleLarge),
                TextButton(
                  onPressed: () {
                    ref.read(ConstantsofSideBar.pageIndexProvider.notifier).state = 1;
                  },
                  child: const Text("View All"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ConstantsOfDashboardReportIssue.ids.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                return _ReportListItem(
                  id: ConstantsOfDashboardReportIssue.ids[index],
                  priority: ConstantsOfDashboardReportIssue.priorities[index],
                  title: ConstantsOfDashboardReportIssue.titles[index],
                  location: ConstantsOfDashboardReportIssue.locations[index],
                  department: ConstantsOfDashboardReportIssue.departments[index],
                  timeAgo: ConstantsOfDashboardReportIssue.timesAgo[index],
                  status: ConstantsOfDashboardReportIssue.statuses[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportListItem extends StatelessWidget {
  final String id;
  final Priority priority;
  final String title;
  final String location;
  final String department;
  final String timeAgo;
  final Status status;

  const _ReportListItem({
    required this.id,
    required this.priority,
    required this.title,
    required this.location,
    required this.department,
    required this.timeAgo,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  id,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                _IssueTag(
                  text: priority.name,
                  backgroundColor: _getPriorityColor(priority),
                  textColor: _getPriorityTextColor(priority),
                ),
              ],
            ),
            _IssueTag(
              text: _getStatusText(status),
              backgroundColor: theme.brightness == Brightness.light
                  ? Colors.grey.shade200
                  : Colors.grey.shade700,
              textColor: theme.textTheme.bodyLarge!.color!,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(title,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(location, style: theme.textTheme.bodySmall),
        const SizedBox(height: 12),
        Row(
          children: [
            _IssueTag(
              text: department,
              backgroundColor: theme.brightness == Brightness.light
                  ? Colors.grey.shade200
                  : Colors.grey.shade700,
              textColor: theme.textTheme.bodyLarge!.color!,
            ),
            const SizedBox(width: 12),
            Text(timeAgo, style: theme.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.High:
        return Colors.red;
      case Priority.Medium:
        return Colors.orange;
      case Priority.Low:
        return Colors.blue;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getPriorityTextColor(Priority priority) {
    switch (priority) {
      case Priority.High:
        return Colors.white;
      case Priority.Medium:
        return Colors.white;
      case Priority.Low:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  String _getStatusText(Status status) {
    switch (status) {
      case Status.New:
        return 'New';
      case Status.Assigned:
        return 'Assigned';
      case Status.InProgress:
        return 'In Progress';
      case Status.Resolved:
        return 'Resolved';
      default:
        return 'Unknown';
    }
  }
}

class _IssueTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _IssueTag({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
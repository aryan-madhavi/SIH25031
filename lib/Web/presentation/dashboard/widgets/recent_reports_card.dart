import 'package:civic_reporter/Web/Core/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RecentReportsCard extends ConsumerWidget {
  const RecentReportsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reportsStream = FirebaseFirestore.instance.collection('reports').orderBy('timestamp', descending: true).limit(3).snapshots();

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
                    ref.read(pageIndexProvider.notifier).state = 1;
                  },
                  child: const Text("View All"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: reportsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) return const Padding(padding: EdgeInsets.all(8.0), child: Text('No recent reports'));

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  separatorBuilder: (context, index) => const Divider(height: 24),
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final id = data['reportId'] ?? docs[index];
                    final title = data['category'] ?? '';
                    final rawLocation = data['location'];
                    String location;
                    if (rawLocation == null) {
                      location = '';
                    } else if (rawLocation is GeoPoint) {
                      location = '${rawLocation.latitude.toStringAsFixed(5)}, ${rawLocation.longitude.toStringAsFixed(5)}';
                    } else if (rawLocation is Map) {
                      final lat = rawLocation['latitude'] ?? rawLocation['lat'] ?? rawLocation['latLng'] ?? rawLocation['latitud'];
                      final lng = rawLocation['longitude'] ?? rawLocation['lng'] ?? rawLocation['lon'] ?? rawLocation['long'];
                      if (lat != null && lng != null) {
                        location = '${lat.toString()}, ${lng.toString()}';
                      } else {
                        location = rawLocation.toString();
                      }
                    } else {
                      location = rawLocation.toString();
                    }
                    final dept = (data['category'] ?? '').toString();
                    final ts = data['timestamp'] as Timestamp?;
                    final lastUpdated = ts != null ? ts.toDate() : DateTime.now();
                    final urgency = (data['urgency'] ?? 'Low') as String;

                    Priority priority = Priority.Low;
                    if (urgency.toLowerCase().contains('high')) {
                      priority = Priority.High;
                    } else if (urgency.toLowerCase().contains('medium')) priority = Priority.Medium;

                    final uid = (data['userId'] ?? '').toString();
                    final statusStr = (data['status'] ?? 'New') as String;
                    Status status = Status.New;
                    if (statusStr.toLowerCase().contains('assigned')) {
                      status = Status.Assigned;
                    } else if (statusStr.toLowerCase().contains('inprogress') || statusStr.toLowerCase().contains('in progress')) status = Status.InProgress;
                    else if (statusStr.toLowerCase().contains('resolved') || statusStr.toLowerCase().contains('successful')) status = Status.Resolved;
                    return FutureBuilder<DocumentSnapshot?>(
                      future: uid.isNotEmpty ? FirebaseFirestore.instance.collection('users').doc(uid).get() : Future<DocumentSnapshot?>.value(null),
                      builder: (context, snap) {
                        String citizen = 'Unknown';
                        if (snap.connectionState == ConnectionState.waiting) {
                          citizen = '—';
                        } else if (snap.hasData && snap.data != null && snap.data!.exists) {
                          final u = snap.data!.data() as Map<String, dynamic>;
                          citizen = (u['name'] ?? u['email'] ?? 'Unknown').toString();
                        } else {
                          citizen = (data['userName'] ?? data['citizenName'] ?? 'Unknown') as String;
                        }

                        return _ReportListItem(
                          id: id,
                          priority: priority,
                          title: title,
                          location: location,
                          department: dept,
                          timeAgo: "Updated: ${DateFormat.yMd().add_jm().format(lastUpdated)}",
                          status: status,
                          citizenName: citizen,
                        );
                      },
                    );
                  },
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
  final String citizenName;

  const _ReportListItem({
    required this.id,
    required this.priority,
    required this.title,
    required this.location,
    required this.department,
    required this.timeAgo,
    required this.status,
    this.citizenName = 'Unknown',
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
                Text(citizenName, style: theme.textTheme.bodySmall),
                const SizedBox(width: 8),
                _IssueTag(
                  text: priority.name,
                  backgroundColor: _getPriorityColor(priority, theme),
                  textColor: _getPriorityTextColor(priority, theme),
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

  Color _getPriorityColor(Priority priority, ThemeData theme) {
    switch (priority) {
      case Priority.High: return Colors.red.shade100;
      case Priority.Medium: return Colors.orange.shade100;
      case Priority.Low: return Colors.blue.shade100;
    }
  }

  Color _getPriorityTextColor(Priority priority, ThemeData theme) {
    switch (priority) {
      case Priority.High: return Colors.red.shade800;
      case Priority.Medium: return Colors.orange.shade800;
      case Priority.Low: return Colors.blue.shade800;
    }
  }

  String _getStatusText(Status status) {
    switch (status) {
      case Status.New: return 'New';
      case Status.Assigned: return 'Assigned';
      case Status.InProgress: return 'In Progress';
      case Status.Resolved: return 'Resolved';
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
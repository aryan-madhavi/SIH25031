import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'dart:html' as html;
import 'package:civic_reporter/Web/Core/Constants/constants.dart';
class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});

  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage> {
  String _selectedColumn = 'All';
  String _filterText = '';

  final List<String> _columns = [
    'All',
    'Issue ID',
    'Category',
    'Citizen',
    'Priority',
    'Status',
    'Assigned To',
    'Submitted',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reportsStream = FirebaseFirestore.instance.collection('reports').orderBy('timestamp', descending: true).snapshots();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Issues", style: theme.textTheme.headlineMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedColumn,
                  items: _columns.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedColumn = v);
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Filter (data init)', border: OutlineInputBorder()),
                    onChanged: (v) => setState(() => _filterText = v.trim()),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(onPressed: () => setState(() { _selectedColumn = 'All'; _filterText = ''; }), child: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 24),
            StreamBuilder<QuerySnapshot>(
              stream: reportsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text('No reports found.'),
                  );
                }
                final docs = snapshot.data!.docs;
                final filtered = docs.where((doc) {
                  if (_filterText.isEmpty) return true;
                  final data = doc.data() as Map<String, dynamic>;
                  final id = (data['reportId'] ?? doc.id).toString();
                  final category = (data['category'] ?? '').toString();
                  final citizen = (data['userName'] ?? data['citizenName'] ?? '').toString();
                  final priority = (data['urgency'] ?? '').toString();
                  final status = (data['status'] ?? '').toString();
                  final assigned = (data['assignedToName'] ?? '').toString();
                  final ts = data['timestamp'] as Timestamp?;
                  final submitted = ts != null ? DateFormat('M/d/yyyy h:mm a').format(ts.toDate()) : '';
                  final val = (_selectedColumn == 'All')
                      ? '$id $category $citizen $priority $status $assigned $submitted'.toLowerCase()
                      : {
                          'Issue ID': id,
                          'Category': category,
                          'Citizen': citizen,
                          'Priority': priority,
                          'Status': status,
                          'Assigned To': assigned,
                          'Submitted': submitted,
                        }[_selectedColumn]?.toString().toLowerCase() ?? '';

                  return val.contains(_filterText.toLowerCase());
                }).toList();

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
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
                          DataColumn(label: Text('Photo')),
                        ],
                        rows: filtered.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final id = data['reportId'] ?? doc.id;
                          final category = (data['category'] ?? '') as String;
                          final uid = (data['userId'] ?? '').toString();
                          final priorityStr = (data['urgency'] ?? 'Low') as String;
                          final statusStr = (data['status'] ?? 'New') as String;
                          final assignedToName = (data['assignedToName'] ?? 'Unassigned') as String;
                          final timestamp = data['timestamp'] as Timestamp?;
                          final submitted = timestamp != null ? timestamp.toDate() : DateTime.now();
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
                          final mediaUrl = (data['mediaUrl'] ?? data['imageUrl'] ?? data['image'] ?? '') as String;
                          Priority priority = Priority.Low;
                          if (priorityStr.toLowerCase().contains('high')) priority = Priority.High;
                          else if (priorityStr.toLowerCase().contains('medium')) priority = Priority.Medium;

                          Status status = Status.New;
                          final sLower = statusStr.toLowerCase();
                          if (sLower.contains('assigned')) status = Status.Assigned;
                          else if (sLower.contains('inprogress') || sLower.contains('in progress')) status = Status.InProgress;
                          else if (sLower.contains('resolved') || sLower.contains('successful') || sLower.contains('done')) status = Status.Resolved;
                          return DataRow(
                            onSelectChanged: (_) => _showFirestoreReportDialog(context, data, location),
                            cells: [
                              DataCell(Text(id.toString())),
                              DataCell(Text(category)),
                              DataCell(
                                FutureBuilder<DocumentSnapshot?>(
                                  future: uid.isNotEmpty ? FirebaseFirestore.instance.collection('users').doc(uid).get() : Future<DocumentSnapshot?>.value(null),
                                  builder: (context, snap) {
                                    if (snap.connectionState == ConnectionState.waiting) return const Text('—');
                                    if (!snap.hasData || snap.data == null || !(snap.data!.exists)) {
                                      final fallback = (data['userName'] ?? data['citizenName'] ?? 'Unknown') as String;
                                      return Text(fallback);
                                    }
                                    final udata = snap.data!.data() as Map<String, dynamic>;
                                    final name = (udata['name'] ?? udata['email'] ?? '').toString();
                                    return Text(name.isNotEmpty ? name : (data['userName'] ?? data['citizenName'] ?? 'Unknown') as String);
                                  },
                                ),
                              ),
                              DataCell(_PriorityTag(priority: priority)),
                              DataCell(_StatusTag(status: status)),
                              DataCell(Text(assignedToName)),
                              DataCell(Text(DateFormat('M/d/yyyy\nh:mm a').format(submitted))),
                              DataCell(
                                IconButton(
                                  icon: const Icon(Icons.image),
                                  onPressed: mediaUrl.isNotEmpty ? () => _showImageDialog(context, mediaUrl) : null,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600, maxWidth: 1000),
            child: FutureBuilder<String?>(
              future: _resolveMediaUrl(imageUrl),
              builder: (context, snap) {
                try {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
                  }
                  if (!snap.hasData || snap.data == null || snap.data!.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Photo Evidence', style: Theme.of(context).textTheme.titleMedium),
                          ),
                          const Expanded(child: Center(child: Text('Could not load image'))),
                          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
                        ],
                      ),
                    );
                  }

                  final url = snap.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Photo Evidence', style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Flexible(
                        child: Image.network(
                          url,
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const SizedBox(height: 200, child: Center(child: Text('Could not load image'))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () {
                              try {
                                html.window.open(url, '_blank');
                              } catch (_) {
                              }
                            },
                            child: const Text('Open in new tab'),
                          ),
                        ],
                      ),
                    ],
                  );
                } catch (e, st) {
                  print('Image preview build error: $e\n$st');
                  return SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Photo Evidence', style: Theme.of(context).textTheme.titleMedium),
                        ),
                        const Expanded(child: Center(child: Text('Could not show preview (dev-only). Use "Open in new tab"'))),
                        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
  Future<String?> _resolveMediaUrl(String media) async {
    try {
      if (media.isEmpty) return null;
      if (media.startsWith('http://') || media.startsWith('https://')) {
        return media;
      }

      final fb = fb_storage.FirebaseStorage.instance;
      if (media.startsWith('gs://')) {
        final ref = fb.refFromURL(media);
        return await ref.getDownloadURL();
      }
      try {
        final ref = fb.ref(media);
        return await ref.getDownloadURL();
      } catch (_) {
        try {
          final ref2 = fb.refFromURL(media);
          return await ref2.getDownloadURL();
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  void _showFirestoreReportDialog(BuildContext context, Map<String, dynamic> data, String location) {
    final id = data['reportId'] ?? '';
    final status = data['status'] ?? '';
    final category = data['category'] ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Report Details: $id'),
          content: Text('Status: $status\nCategory: $category\nLocation: $location'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
          ],
        );
      },
    );
  }
}

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
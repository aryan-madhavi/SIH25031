// lib/data/repository/report_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> submitReport({
    required String description,
    required String category,
    required String urgency,
    required GeoPoint location,
    required String mediaUrl,
  }) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('User Not Logged In');
    }
    final reportRef = firestore.collection("reports").doc();

    await reportRef.set({
      "reportId": reportRef.id,
      "userId": currentUser.uid,
      "description": description,
      "category": category,
      "urgency": urgency,
      "location": location,
      "mediaUrl": mediaUrl,
      "timestamp": FieldValue.serverTimestamp(),
      "status": "pending",
      "responseTime": 0,
    });

    await firestore.collection("users").doc(currentUser.uid).update({
      "totalreports": FieldValue.increment(1),
    });
  }
}

final reportRepositoryProvider = Provider.autoDispose((ref) => ReportRepository());
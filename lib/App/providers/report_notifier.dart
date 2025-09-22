import 'dart:io';

import 'package:civic_reporter/App/data/model/report_model.dart';
import 'package:civic_reporter/App/data/repository/report_repository.dart';
import 'package:civic_reporter/App/data/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uuid/uuid.dart';

class ReportNotifier extends StateNotifier<ReportModel> {
  
  ReportNotifier() : super(ReportModel());

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void updateUrgency(String urgency) {
    state = state.copyWith(urgency: urgency);
  }

  void updatemediaFile(File? mediaFile) {
    state = state.copyWith(mediaFile: mediaFile);
  }

  void updatelocation(GeoPoint location) {
    state = state.copyWith(location: location);
  }

  void resetReport() {
    state = ReportModel();
  }

  Future<void> submitReport({

    required ReportRepository reportRepo,
    required StorageServices storageService,

  }) async {
    state = state.copyWith(isLoading: true);
    try {
      if (state.mediaFile == null || state.location == null) {
        throw Exception("Please provide an image and location.");
      }

      final String uuid = Uuid().v4();
      final mediaUrl = await storageService.uploadFileToStorage(
        state.mediaFile!,
        "report_media/$uuid.jpg",
      );

      await reportRepo.submitReport(
        description: state.description,
        category: state.category,
        urgency: state.urgency,
        location: state.location!,
        mediaUrl: mediaUrl,
      );

      state = state.copyWith(isLoading: false);

      resetReport();
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}

final reportNotifierProvider = StateNotifierProvider.autoDispose((ref) {
  return ReportNotifier();
});

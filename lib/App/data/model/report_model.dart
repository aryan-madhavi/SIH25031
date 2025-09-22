// lib/data/model/report_model.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String description;
  final String category;
  final String urgency;
  final File? mediaFile;
  final GeoPoint? location;
  final bool isLoading;

  ReportModel({
    this.description = "",
    this.category = "",
    this.urgency = "Low",
    this.mediaFile,
    this.location,
    this.isLoading = false,
  });

  
  ReportModel copyWith({
    String? description,
    String? category,
    String? urgency,
    File? mediaFile,
    GeoPoint? location,
    bool? isLoading,
  }) {
    return ReportModel(
      description: description ?? this.description,
      category: category ?? this.category,
      urgency: urgency ?? this.urgency,
      mediaFile: mediaFile ?? this.mediaFile,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

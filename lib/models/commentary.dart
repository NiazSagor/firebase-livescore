import 'package:cloud_firestore/cloud_firestore.dart';

class CommentaryModel {
  final String id;
  final double over;        // Changed to double for math/sorting (e.g., 2.1)
  final String description; // Matches the 'description' field in Firestore
  final String runs;        // Matches the 'runs' field in Firestore
  final DateTime? timestamp;

  CommentaryModel({
    required this.id,
    required this.over,
    required this.description,
    required this.runs,
    this.timestamp,
  });

  factory CommentaryModel.fromMap(String id, Map<String, dynamic>? data) {
    // 1. Safety check for null data
    if (data == null) {
      return CommentaryModel(
        id: id,
        over: 0.0,
        description: 'No data',
        runs: '0',
      );
    }

    // 2. Map fields to the actual Firestore keys we used earlier
    return CommentaryModel(
      id: id,
      // Use .toDouble() because Firestore might store 2 as an int or 2.1 as a double
      over: (data['over'] ?? 0.0).toDouble(),
      description: data['description'] ?? 'Ball commentary unavailable',
      runs: data['runs']?.toString() ?? '0',
      // Convert Firestore Timestamp to Dart DateTime
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : null,
    );
  }
}
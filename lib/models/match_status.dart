import 'package:flutter/material.dart';

enum MatchStatus {
  // Define the constants with their specific data
  live(
    label: 'LIVE',
    statusColor: Colors.red,
    isInPlay: true,
  ),
  upcoming(
    label: 'UPCOMING',
    statusColor: Colors.blue,
    isInPlay: false,
  ),
  finished(
    label: 'FINISHED',
    statusColor: Colors.grey,
    isInPlay: false,
  );

  // Define the fields each status must have
  final String label;
  final Color statusColor;
  final bool isInPlay;

  // The constructor must be 'const' for Enums
  const MatchStatus({
    required this.label,
    required this.statusColor,
    required this.isInPlay,
  });

  // Helper method to parse strings from Firestore safely
  static MatchStatus fromString(String status) {
    return MatchStatus.values.firstWhere(
          (e) => e.name == status.toLowerCase(),
      orElse: () => MatchStatus.upcoming,
    );
  }
}

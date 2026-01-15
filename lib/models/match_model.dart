import 'package:firebase_livescore/models/match_status.dart';

class MatchModel {
  final String teamA;
  final String teamB;
  final String scoreA;
  final String scoreB;
  final String logoA;
  final String logoB;
  final MatchStatus status;

  MatchModel({
    required this.teamA,
    required this.teamB,
    required this.scoreA,
    required this.scoreB,
    required this.logoA,
    required this.logoB,
    required this.status,
  });

  // This factory constructor is the "Shield" for your app
  factory MatchModel.fromMap(Map<String, dynamic>? data) {
    // 1. If the entire document is null, return a "Placeholder" model
    if (data == null) {
      return MatchModel.empty();
    }

    // 2. Map fields with null-coalescing (??) fallbacks
    return MatchModel(
      teamA: data['teamA'] ?? 'TBD',
      teamB: data['teamB'] ?? 'TBD',
      scoreA: data['scoreA'] ?? '0/0 (0)',
      scoreB: data['scoreB'] ?? '0/0 (0)',
      logoA: data['logoA'] ?? '', // Empty string won't crash CachedNetworkImage
      logoB: data['logoB'] ?? '',
      status: MatchStatus.fromString(data['status'] ?? 'upcoming'),
    );
  }

  // A helper for when there is no data at all
  factory MatchModel.empty() {
    return MatchModel(
      teamA: 'Team A',
      teamB: 'Team B',
      scoreA: '-',
      scoreB: '-',
      logoA: '',
      logoB: '',
      status: MatchStatus.upcoming,
    );
  }
}
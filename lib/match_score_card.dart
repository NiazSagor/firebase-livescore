import 'package:firebase_livescore/status_badge.dart';
import 'package:firebase_livescore/team_column.dart';
import 'package:firebase_livescore/viewmodels/match_viewmodel.dart';
import 'package:flutter/material.dart';

class MatchScoreboardCard extends StatelessWidget {
  final MatchViewModel viewModel;

  const MatchScoreboardCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final match = viewModel.currentMatch;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Status Badge using Enhanced Enum
            StatusBadge(status: match.status),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TeamColumn(
                  name: match.teamA,
                  score: match.scoreA,
                  logo: match.logoA,
                ),
                const Text("vs", style: TextStyle(fontWeight: FontWeight.bold)),
                TeamColumn(
                  name: match.teamB,
                  score: match.scoreB,
                  logo: match.logoB,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

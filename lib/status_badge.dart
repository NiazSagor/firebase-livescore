import 'package:firebase_livescore/models/match_status.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final MatchStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        // We use the color defined directly in the Enum
        color: status.statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: status.statusColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // If the match is live, show a small blinking-style dot
          if (status.isInPlay)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: status.statusColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          Text(
            status.label,
            style: TextStyle(
              color: status.statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

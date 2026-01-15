import 'package:firebase_livescore/models/commentary.dart';
import 'package:flutter/material.dart';

class CommentaryTile extends StatelessWidget {
  final CommentaryModel ball;

  const CommentaryTile({super.key, required this.ball});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Over Number and Outcome Circle
          Column(
            children: [
              Text(
                ball.over.toStringAsFixed(1), // Uses the double 'over' from model
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _OutcomeCircle(runs: ball.runs), // Changed 'event' to 'runs'
            ],
          ),
          const SizedBox(width: 16),
          // 2. Commentary Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the description from Firestore
                Text(
                  ball.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OutcomeCircle extends StatelessWidget {
  final String runs;
  const _OutcomeCircle({required this.runs});

  @override
  Widget build(BuildContext context) {
    // Determine color and label based on the 'runs' string
    final (color, label) = switch (runs.toUpperCase()) {
      'W' || 'WICKET' => (Colors.red, 'W'),
      '6'             => (Colors.purple, '6'),
      '4'             => (Colors.blue, '4'),
      '0'             => (Colors.grey.shade400, '0'),
      _               => (Colors.green.shade600, runs), // 1, 2, 3 runs
    };

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          if (runs == '6' || runs == '4' || runs.toUpperCase() == 'W')
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
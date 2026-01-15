import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamColumn extends StatelessWidget {
  final String name;
  final String score;
  final String logo;

  const TeamColumn({
    super.key,
    required this.name,
    required this.score,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Team Logo with rounded container
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(
            imageUrl: logo,
            height: 50,
            width: 50,
            // Using the error placeholder logic we discussed!
            errorWidget: (context, url, error) => const Icon(Icons.shield, size: 40),
            placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        const SizedBox(height: 8),

        // 2. Team Abbreviation (e.g., IND)
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),

        // 3. Current Score
        Text(
          score,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

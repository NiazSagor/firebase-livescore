import 'package:firebase_livescore/live_score_screen.dart';
import 'package:firebase_livescore/models/match_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Cricket Matches'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Listen to all documents in the 'matches' collection
        stream: FirebaseFirestore.instance.collection('matches').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('Something went wrong'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final matches = snapshot.data!.docs;

          if (matches.isEmpty) {
            return const Center(child: Text('No matches available right now.'));
          }

          return ListView.builder(
            itemCount: matches.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final doc = matches[index];
              final data = doc.data() as Map<String, dynamic>;

              // We use our MatchModel to parse the data safely
              final match = MatchModel.fromMap(data);

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(match.teamA, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text("vs", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(match.teamB, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Status: ${match.status.label}"),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to the details screen using the Document ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveScoreScreen(matchId: doc.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
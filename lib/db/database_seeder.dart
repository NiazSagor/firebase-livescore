import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSeeder {
  static Future<void> seedMatches() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final WriteBatch batch = db.batch();

    // --- 1. Define Dummy Matches ---
    final List<Map<String, dynamic>> matchesData = [
      {
        'id': 'match_001',
        'teamA': 'India',
        'teamB': 'Pakistan',
        'scoreA': '184/3 (18.2)',
        'scoreB': '182/8 (20.0)',
        'logoA': 'https://example.com/ind.png',
        'logoB': 'https://example.com/pak.png',
        'status': 'live', // Matches enum logic
      },
      {
        'id': 'match_002',
        'teamA': 'Australia',
        'teamB': 'England',
        'scoreA': '0/0 (0.0)',
        'scoreB': '0/0 (0.0)',
        'logoA': 'https://example.com/aus.png',
        'logoB': 'https://example.com/eng.png',
        'status': 'upcoming',
      },
      {
        'id': 'match_003',
        'teamA': 'South Africa',
        'teamB': 'New Zealand',
        'scoreA': '245/10 (48.4)',
        'scoreB': '248/4 (45.2)',
        'logoA': 'https://example.com/sa.png',
        'logoB': 'https://example.com/nz.png',
        'status': 'finished',
      }
    ];

    // --- 2. Add Matches to Batch ---
    for (var match in matchesData) {
      final docRef = db.collection('matches').doc(match['id']);
      batch.set(docRef, {
        'teamA': match['teamA'],
        'teamB': match['teamB'],
        'scoreA': match['scoreA'],
        'scoreB': match['scoreB'],
        'logoA': match['logoA'],
        'logoB': match['logoB'],
        'status': match['status'],
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // --- 3. Add Commentary for the Live Match ---
    final List<Map<String, dynamic>> commentaryData = [
      {'over': 18.2, 'runs': '6', 'desc': 'MASSIVE! Kohli smokes it over long-on!'},
      {'over': 18.1, 'runs': '1', 'desc': 'Short ball, pulled away to deep mid-wicket.'},
      {'over': 17.6, 'runs': 'W', 'desc': 'OUT! The captain falls! Top edge taken.'},
      {'over': 17.5, 'runs': '4', 'desc': 'CRACKED! Beautiful cover drive for four.'},
    ];

    for (var i = 0; i < commentaryData.length; i++) {
      final commRef = db
          .collection('matches')
          .doc('match_001') // Adding to India vs Pakistan
          .collection('commentary')
          .doc('ball_$i');

      batch.set(commRef, {
        'over': commentaryData[i]['over'],
        'runs': commentaryData[i]['runs'],
        'description': commentaryData[i]['desc'],
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // --- 4. Commit everything at once ---
    await batch.commit();
    print("✅ Database successfully seeded!");
  }
}

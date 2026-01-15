import 'dart:async';
import 'package:firebase_livescore/models/commentary.dart';
import 'package:firebase_livescore/models/match_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchViewModel extends ChangeNotifier {
  final String matchId;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. Declare the MatchModel (nullable initially)
  MatchModel _currentMatch = MatchModel.empty();
  List<CommentaryModel> _commentary = [];

  StreamSubscription? _matchSub;
  StreamSubscription? _commSub;

  MatchViewModel({required this.matchId}) {
    _startListeners();
  }

  // Getters
  MatchModel get currentMatch => _currentMatch;
  List<CommentaryModel> get commentary => _commentary;

  void _startListeners() {
    // 2. Listen to the main Match Document
    _matchSub = _db.collection('matches')
        .doc(matchId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        // Use the new factory we refactored
        _currentMatch = MatchModel.fromMap(snapshot.data());
      } else {
        _currentMatch = MatchModel.empty();
      }
      notifyListeners(); // Tell the UI to rebuild safely
    });

    // 3. Listen to the Commentary Sub-collection
    _commSub = _db
        .collection('matches')
        .doc(matchId)
        .collection('commentary')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _commentary = snapshot.docs
          .map((doc) => CommentaryModel.fromMap(doc.id, doc.data()))
          .toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _matchSub?.cancel();
    _commSub?.cancel();
    super.dispose();
  }
}
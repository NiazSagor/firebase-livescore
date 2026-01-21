import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_livescore/live_score_screen.dart';
import 'package:firebase_livescore/viewmodels/match_viewmodel.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. User is NOT logged in - Show Predefined Firebase UI
        if (!snapshot.hasData) {
          return LiveScoreScreen(viewModel: context.watch<MatchViewModel>());
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: "142000257856-8v8ovum4hvh4okagp38f21fk5p5l29cg.apps.googleusercontent.com"),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    const Icon(Icons.sports_cricket, size: 80, color: Colors.green),
                    Text(
                      "CricDash Live",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome back! Please sign in to see live scores.'
                      : 'Create an account to track your favorite teams!',
                ),
              );
            },
          );
        }

        // 3. User IS logged in - Show the Match Data
        return LiveScoreScreen(viewModel: context.watch<MatchViewModel>());
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_livescore/auth_gate.dart';
import 'package:firebase_livescore/firebase_options.dart';
import 'package:firebase_livescore/viewmodels/match_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

void main() async {
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase with the generated options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    // 3. Provide the ViewModel at the very top so any screen can access it
    ChangeNotifierProvider(
      create: (context) => MatchViewModel(matchId: "match_1"), // Example ID
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CricDash Live',
      navigatorObservers: [observer],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      // 4. Start at the AuthGate to check if user is logged in
      home: const AuthGate(),
    );
  }
}

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_cricket, size: 100, color: Colors.green),
            const Text("CricDash", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              icon: Image.asset('assets/google_logo.png', height: 24),
              label: const Text("Sign in with Gmail"),
              onPressed: () {
                /*handleSignIn(context)*/
              },
            ),
          ],
        ),
      ),
    );
  }
}

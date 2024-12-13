import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current logged-in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<Map<String, dynamic>?> getUserDetails() async {
    if (currentUser == null) {
      throw Exception("User is not logged in");
    }

    // Fetch user document from Firestore using UID
    final doc = await FirebaseFirestore.instance.collection("Users").doc(currentUser!.uid).get();

    return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // Data received
          else if (snapshot.hasData) {
            final user = snapshot.data;

            if (user == null) {
              return const Center(
                child: Text("No user data found."),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Email: ${user['email'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Username: ${user['username'] ?? 'N/A'}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No data available."),
            );
          }
        },
      ),
    );
  }
}

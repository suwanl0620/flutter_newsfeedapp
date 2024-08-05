import 'package:flutter_newsfeed/units/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                Map<String, dynamic>? user = snapshot.data!.data();
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MyBackButton(),

                      const SizedBox(height: 25), // spacing

                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.person, size: 80),
                      ),

                      const SizedBox(height: 25), // spacing

                      Text(user!['username'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(user!['email'], style: TextStyle(color: Colors.grey[600])),
                      
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("No data found"));
              }
           }
      )
    );
  }
}

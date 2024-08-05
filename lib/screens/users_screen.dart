import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/helper/helper_functions.dart';
import 'package:flutter_newsfeed/units/my_back_button.dart';
import 'package:flutter_newsfeed/units/my_list_tile.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            displayMessagePopUp("Error has occurred", context);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(child: Text("No data found"));
          }
          final users = snapshot.data!.docs;
          return Column(
            children: [
              
              const Padding(
                padding: EdgeInsets.only(top: 50.0, left: 25),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),

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
              
              // list of users in app
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      String username = user['username'];
                      String email = user['email'];

                      return MyListTile(title: username, subTitle: email);
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}

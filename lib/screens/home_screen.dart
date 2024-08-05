import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/units/my_drawer.dart';
import 'package:flutter_newsfeed/units/my_textfield.dart';
import 'package:flutter_newsfeed/units/my_post_button.dart';
import 'package:flutter_newsfeed/post_database/firestore.dart';
import 'package:flutter_newsfeed/units/my_list_tile.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});
  
  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      // post message
      database.addPost(newPostController.text);
    }
    newPostController.clear();
  }

  void likePost(String postId) { // like functionality not implemented
    database.incrementLikes(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Theme.of(context).colorScheme.surface,

        appBar: AppBar(
          title: const Text("Posts"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
        ),

        drawer: const MyDrawer(),

        body: Column(children: [
          // textfield for user input
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "What's on your mind?",
                      obscureText: false,
                      controller: newPostController),
                ),

                // post button
                PostButton(onTap: postMessage)
              ],
            ),
          ),
          // list of posts
          StreamBuilder(
              stream: database.getPosts(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final posts = snapshot.data!.docs;

                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text("No posts yet!")),
                    )
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        String message = post['PostMessage'];
                        String userEmail = post['UserEmail'];
                        String timestamp = post['Timestamp'];
                        return MyListTile(
                          title: message, 
                          subTitle: userEmail, 
                          timestamp: timestamp
                        );
                      }
                  ),
                );
              })
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(children: [
        // drawer header
        DrawerHeader
          (child: Icon(
            Icons.favorite,
            color: Theme.of(context).colorScheme.inversePrimary
            ),
          ),

        const SizedBox(height: 25),

        // home tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(leading: Icon(Icons.home), title: const Text("Home"), 
            onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/home_screen');
            },
          ),
        ),

        // profile tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(leading: Icon(Icons.person), title: const Text("Profile"), 
            onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/profile_screen');
            },
          ),
        ),

        //users tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(leading: Icon(Icons.group), title: const Text("Users"), 
            onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/users_screen');
            },
          ),
        ),

        //log out tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(leading: Icon(Icons.home), title: Text("Log Out"), 
            onTap: () async {
            Navigator.pop(context);
            await FirebaseAuth.instance.signOut();
            },
          ),
        ),
      ],)
      );
    
  }
}
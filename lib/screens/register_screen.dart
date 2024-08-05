import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/units/my_textfield.dart';
import 'package:flutter_newsfeed/units/my_button.dart';
import 'package:flutter_newsfeed/helper/helper_functions.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pwConfirmController = TextEditingController();

  void registerUser() async {

    // loading
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    // check if password and confirm password match
    if (passwordController.text != pwConfirmController.text) {
      // show error message
      displayMessagePopUp(
          "Password and Confirm Password do not match", context);
      // close loading
      Navigator.pop(context);
      return;

    } else {

      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        // create user document and add to firestore
        createUserDocument(userCredential);

        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          displayMessagePopUp("The password provided is too weak.", context);
        } else if (e.code == 'email-already-in-use') {
          displayMessagePopUp(
              "The account already exists for that email.", context);
        }
      } catch (e) {
        displayMessagePopUp(e.toString(), context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async{
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.email).set({
        "username": usernameController.text,
        "email": userCredential.user!.email,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25), // spacing

              // email textfield
               MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),


              // username textfield
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                hintText: "Password",
                obscureText: true, // hide password input
                controller: passwordController,
              ),

              const SizedBox(height: 10),

              MyTextField(
                hintText: "Confirm Password",
                obscureText: true, // hide password input
                controller: pwConfirmController,
              ),

              const SizedBox(height: 10),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // register button
              MyButton(
                text: "Sign Up",
                onTap: registerUser,
              ),

              Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text("Log In here",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

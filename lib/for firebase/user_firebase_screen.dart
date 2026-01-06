import 'package:broadway_example_ui/for%20firebase/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseUser extends StatefulWidget {
  const FirebaseUser({super.key});

  @override
  State<FirebaseUser> createState() => _FirebaseUserState();
}

class _FirebaseUserState extends State<FirebaseUser> {
  FirebaseService service = FirebaseService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text("Name"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("Email"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final Map<String, dynamic> json = {
                  'name': nameController.text,
                  'email': emailController.text,
                };
                service.addUsers(json);
                nameController.clear();
                emailController.clear();
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

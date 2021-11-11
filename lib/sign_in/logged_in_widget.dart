import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'google_sign_in.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.black,
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          FlatButton(
            color: Colors.blueAccent,
            textColor: Colors.black,
            child: const Text('Logout'),
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            const SizedBox(height: 8),
            Text(
              'Name: '+ user.displayName!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: '+user.email!,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );

  }
}

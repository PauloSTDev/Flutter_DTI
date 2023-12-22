import 'package:dti/models/drawer_widget.dart';
import 'package:dti/models/sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Purchase extends StatelessWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("Sucesso"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueAccent,
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            ),
            child: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Compra efetuada com sucesso!',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

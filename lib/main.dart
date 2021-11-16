import 'package:dti/controllers/total_controller.dart';
import 'package:dti/models/read_examples.dart';
import 'package:dti/models/sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<GoogleSignInProvider>.value(value: GoogleSignInProvider(),),
      ChangeNotifierProvider<TotalController>.value(value: TotalController(),),
    ],
    child: MaterialApp(
      title: 'DTI',
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent)),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    )
  );
  }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context)  => Scaffold(
    backgroundColor: Colors.white,
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }

        else if (snapshot.hasData) {
          return const ReadExamples();
        }

        else if (snapshot.hasError) {
          return const Login();
        }

        else {
          return const Login();
        }
      },
    ),
  );

  Container buildPage(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 50.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

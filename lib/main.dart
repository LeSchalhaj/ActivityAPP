import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
// Autres imports si nécessaire...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(user: user));
}


class MyApp extends StatelessWidget {
  final User? user;

  MyApp({this.user});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma première application Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Point d'entrée sur l'écran de connexion
      routes: {
        '/login': (context) => LoginScreen(), // Ajouter une route pour l'écran de connexion
        // Vous pouvez ajouter d'autres routes ici si nécessaire
      },
    );
  }
}

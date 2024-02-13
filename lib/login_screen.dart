import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:activityman/activities_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: loginController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ActivitiesScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Erreur inconnue';
      if (e.code == 'user-not-found') {
        message = 'Aucun utilisateur trouvé pour cet e-mail.';
      } else if (e.code == 'wrong-password') {
        message = 'Mot de passe incorrect pour cet e-mail.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _registerWithEmailAndPassword() async {
    if (loginController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("L'email et le mot de passe ne peuvent pas être vides")),
      );
      return;
    }
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: loginController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Inscription réussie, veuillez vous connecter")),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Erreur d'inscription")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.deepPurple.shade100,
              Colors.deepPurple.shade400,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60.0,
                    child: ClipOval(child: Image.asset('assets/images/arrier.png')),
                  ),
                  SizedBox(height: 45.0),
                  _buildTextField(loginController, 'Email', Icons.email),
                  SizedBox(height: 25.0),
                  _buildTextField(passwordController, 'Mot de passe', Icons.lock, isPassword: true),
                  SizedBox(height: 35.0),
                  _buildSignInButton(),
                  SizedBox(height: 15.0),
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(fontSize: 18.0, color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.deepPurple.shade200,
        icon: Icon(icon, color: Colors.white),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: _signInWithEmailAndPassword,
      child: Text('Se connecter', style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        primary: Colors.purple,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(15.0),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _registerWithEmailAndPassword,
      child: Text('S\'inscrire', style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        primary: Colors.pink,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.all(15.0),
      ),
    );
  }
}

import 'package:activityman/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Classe principale du profil utilisateur
class YourProfilePageWidget extends StatelessWidget {
  YourProfilePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
        ],
      ),
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Utilisateur non connecté'));
          } else {
            User user = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage(user.photoURL ?? 'https://www.gravatar.com/avatar/placeholder'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    user.displayName ?? ' Hello',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.email!,
                    style: TextStyle(fontSize: 20.0, color: Colors.black54),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.deepPurple),
                    title: Text('Mon profil'),
                    onTap: () {
                      // Naviguer vers la page de profil
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.deepPurple),
                    title: Text('Paramètres'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.deepPurple),
                    title: Text('Se déconnecter'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// Classe pour la page de modification du profil
class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le profil"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text("Page de modification du profil"),
      ),
    );
  }
}

// Classe pour la page des paramètres
class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text("Page des paramètres"),
      ),
    );
  }
}

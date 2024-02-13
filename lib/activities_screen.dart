import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'YourActivitiesPageWidget.dart';
import 'YourCartPageWidget.dart';
import 'YourProfilePageWidget.dart';
import 'AddActivityScreen.dart'; // Assurez-vous d'importer AddActivityScreen

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Widget pageContent = YourActivitiesPageWidget(user: user);

    if (_selectedIndex == 1) {
      pageContent = YourCartPageWidget();
    } else if (_selectedIndex == 2) {
      pageContent = YourProfilePageWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Activités'),
      ),
      body: Center(
        child: pageContent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Activités',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers AddActivityScreen lors du tap sur le bouton
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddActivityScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Ajouter une activité',
      ),
    );
  }
}

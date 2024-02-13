import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityDetailPage extends StatefulWidget {
  final Map<String, dynamic> activity;
  final User? user;

  const ActivityDetailPage({Key? key, required this.activity, required this.user}) : super(key: key);

  @override
  _ActivityDetailPageState createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  Future<void> _addToCart() async {
    if (widget.user == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Veuillez vous connecter pour ajouter cette activité à votre panier.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final userCartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user!.uid)
          .collection('cart');
      final activityId = widget.activity['id'] ?? DateTime.now().toIso8601String(); // Générer un ID si absent

      final doc = await userCartRef.doc(activityId).get();

      if (doc.exists) {
        await userCartRef.doc(activityId).update({'quantity': FieldValue.increment(1)});
      } else {
        await userCartRef.doc(activityId).set({
          ...widget.activity,
          'quantity': 1,
        });
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Succès'),
          content: const Text('L\'activité a été ajoutée à votre panier.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erreur'),
          content: Text('Erreur lors de l\'ajout au panier : $e'),
          actions: <Widget>[
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détail de l\'activité'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.activity['image']),
            Text('Titre : ${widget.activity['title']}'),
            Text('Lieu : ${widget.activity['location']}'),
            Text('Prix : ${widget.activity['price'].toString()}'),
            ElevatedButton(
              onPressed: _addToCart,
              child: const Text('Ajouter au panier'),
            ),
          ],
        ),
      ),
    );
  }
}

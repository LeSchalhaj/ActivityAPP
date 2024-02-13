import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class YourCartPageWidget extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  void _adjustQuantity(String activityId, int delta) {
    if (user == null) return;

    final userCartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    userCartRef.doc(activityId).update({
      'quantity': FieldValue.increment(delta)
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Center(child: Text('Veuillez vous connecter pour voir le panier.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('cart')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Une erreur est survenue'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Votre panier est vide'));
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            var activity = doc.data() as Map<String, dynamic>;
            return ListTile(
              leading: Image.network(activity['image'], width: 50, height: 50),
              title: Text(activity['title']),
              subtitle: Text('\$${activity['price']} x ${activity['quantity']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    color: Colors.red,
                    onPressed: () {
                      if (activity['quantity'] == 1) {
                        // Si la quantité est de 1, supprimez l'article du panier.
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .collection('cart')
                            .doc(doc.id)
                            .delete();
                      } else {
                        // Sinon, décrémentez la quantité.
                        _adjustQuantity(doc.id, -1);
                      }
                    },
                  ),
                  Text('${activity['quantity']}'),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.green,
                    onPressed: () => _adjustQuantity(doc.id, 1),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

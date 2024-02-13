import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart'; 


import 'package:activityman/ActivityDetailPage.dart';

class YourActivitiesPageWidget extends StatelessWidget {
    final User? user; // Déclarez la variable user de type User
      YourActivitiesPageWidget({required this.user});


  // Exemple de données d'activités
  final List<Map<String, dynamic>>  staticActivities = [
    {
      'image': 'https://img.freepik.com/free-vector/guide-trip-background-with-nature-sightseeing-symbols-flat-vector-illsutration_1284-82177.jpg?w=1480&t=st=1705326597~exp=1705327197~hmac=22a9a2b89b9618c462ba434121787f02a777de2552fde8f8d05358fd95810584',
      'title': 'Randonnée en montagne',
      'location': 'Montagnes Rocheuses',
      'price': '\$50',
    },
    {
      'image': 'https://img.freepik.com/free-vector/new-normal-museums-concept_23-2148587884.jpg?w=1380&t=st=1705326648~exp=1705327248~hmac=e31d49c958977b461ae3715fd2b553abed8ece6c7e3c2ad82fdfec21e4789547',
      'title': 'Visite d\'un musée',
      'location': 'Musée d\'art moderne',
      'price': '\$20',
    },
    {
      'image': 'https://img.freepik.com/free-photo/people-taking-part-dance-therapy-class_23-2149346545.jpg?w=1380&t=st=1705326858~exp=1705327458~hmac=437dd213cd66377ceb9dd27ba04188b66816da39a8607984250e5bf40a345db5',
      'title': 'Cours de danse',
      'location': 'Studio de danse XYZ',
      'price': '\$30',
    },
    {
      'image': 'https://img.freepik.com/free-vector/flat-summer-background_23-2149408045.jpg?w=1380&t=st=1705326896~exp=1705327496~hmac=aafe814e7cf0676e23d6903757ff47b34b6ebb01dff57a588057f0765ddcae0e',
      'title': 'Journée à la plage',
      'location': 'Plage ensoleillée',
      'price': '\$10',
    },
    {
      'image': 'https://img.freepik.com/free-vector/man-woman-riding-bicycles-with-green-landscape-background_1262-19803.jpg?w=1380&t=st=1705326927~exp=1705327527~hmac=d8547a409485a78db6b668abe49d8bb06a3655fafabd21412936ad0b82da8f05',
      'title': 'Sortie en vélo',
      'location': 'Parc cyclable',
      'price': '\$15',
    },
    {
  'image': 'https://img.freepik.com/free-vector/people-sportswear-with-rope-training-climbing-rock-wall-extreme-sportsmen-sportswomen-adventure-park_575670-1011.jpg?w=740&t=st=1705327033~exp=1705327633~hmac=4a6a2121e4f82a176f90480c3f8e57353564bf2a26dddd2f85d4725190563e14',
  'title': 'Escalade en montagne',
  'location': 'Montagnes Rocheuses',
  'price': '\$60',
},
{
  'image': 'https://img.freepik.com/free-vector/kayaking-concept-illustration_114360-9306.jpg?w=1380&t=st=1705327063~exp=1705327663~hmac=97c0701853adfc6f60848cd93f68f96fb7bdf3043e67c018866057d1ab4683a9',
  'title': 'Excursion en kayak',
  'location': 'Rivière tranquille',
  'price': '\$25',
},
{
  'image': 'https://img.freepik.com/premium-vector/people-travel-summer-holiday-traveling-couple-walking-city-street-tourists-looking-country-map-location-landmarks-persons-tour-adventure-flat-isolated-vector-illustration-white_633472-2446.jpg',
  'title': 'Visite guidée de la ville',
  'location': 'Centre-ville historique',
  'price': '\$40',
},
{
  'image': 'https://img.freepik.com/free-photo/full-shot-women-meditating-outdoors_23-2149698181.jpg?w=740&t=st=1705327119~exp=1705327719~hmac=7fdf19ccfb848176eef92ba51c69fa9c02b2b2e509c1033273e5a269b3f3da2f',
  'title': 'Séance de yoga en plein air',
  'location': 'Parc naturel',
  'price': '\$20',
}
  ];
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Activités disponibles'),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('activities').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erreur lors du chargement des activités');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var firestoreActivities = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          // Ajouter des vérifications pour les valeurs nulles ici
          String imageUrl = data['image'] ?? 'https://img.freepik.com/premium-vector/people-travel-summer-holiday-traveling-couple-walking-city-street-tourists-looking-country-map-location-landmarks-persons-tour-adventure-flat-isolated-vector-illustration-white_633472-2446.jpg';
          String title = data['title'] ?? 'Titre inconnu';
          String location = data['location'] ?? 'Lieu inconnu';
          double price = data['price'] ?? 0.0;

          return {
            'id': doc.id,
            'image': imageUrl,
            'title': title,
            'location': location,
            'price': price,
          };
        }).toList();

        var combinedActivities = List<Map<String, dynamic>>.from(staticActivities)
          ..addAll(firestoreActivities);

        return ListView.builder(
          itemCount: combinedActivities.length,
          itemBuilder: (context, index) {
            final activity = combinedActivities[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: activity['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              title: Text(activity['title']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity['location']),
                  Text('\$${activity['price'].toString()}'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityDetailPage(
                      activity: activity,
                      user: user,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    ),
  );
}
}
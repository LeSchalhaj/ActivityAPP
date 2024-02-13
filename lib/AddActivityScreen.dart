import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  String _title = '';
  String _category = '';
  String _location = '';
  int _minPeople = 1;
  double _price = 0.0;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile?.path;
    });
  }

  Future<void> _saveActivity() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('activities').add({
        'image': _image,
        'title': _title,
        'category': _category,
        'location': _location,
        'minPeople': _minPeople,
        'price': _price,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Activité créée avec succès!')),
        );
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la création de l\'activité')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une nouvelle activité'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Titre'),
              onSaved: (value) => _title = value!,
              validator: (value) => value!.isEmpty ? 'Ce champ ne peut pas être vide' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Catégorie'),
              onSaved: (value) => _category = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Lieu'),
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre de personnes minimum'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _minPeople = int.parse(value!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _price = double.parse(value!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveActivity,
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}

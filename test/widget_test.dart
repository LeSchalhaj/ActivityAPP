import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:activityman/main.dart'; // Remplacez par le chemin correct vers votre fichier main.dart.

void main() {
  testWidgets('MyApp has a title and message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Vérifiez que le titre est présent dans l'app bar.
    expect(find.text('Ma première application Flutter'), findsOneWidget);

    // Tapez sur le bouton pour naviguer à la page suivante.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Attend que toutes les animations soient terminées.

    // Vérifiez que la page suivante est bien affichée.
    expect(find.text('Bienvenue sur la page suivante !'), findsOneWidget);
  });
}

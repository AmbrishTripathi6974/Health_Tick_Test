import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedSpeciesData() async {
  final firestore = FirebaseFirestore.instance;

  final speciesData = [
    {
      'id': 'species_1',
      'stages': 2,
      'stageParams': [
        {'color': 'green', 'height': 40},
        {'color': 'darkGreen', 'height': 80},
      ]
    },
    {
      'id': 'species_2',
      'stages': 3,
      'stageParams': [
        {'color': 'lightGreen', 'height': 30},
        {'color': 'green', 'height': 70},
        {'color': 'darkGreen', 'height': 120},
      ]
    },
    {
      'id': 'species_3',
      'stages': 4,
      'stageParams': [
        {'color': 'lime', 'height': 25},
        {'color': 'lightGreen', 'height': 55},
        {'color': 'green', 'height': 90},
        {'color': 'deepGreen', 'height': 150},
      ]
    },
  ];

  for (final species in speciesData) {
    await firestore.collection('species').doc(species['id'] as String?).set(species);
    print('Seeded: ${species['id']}');
  }
}

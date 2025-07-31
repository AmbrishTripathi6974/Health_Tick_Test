import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> seedUserProgressAndForest(String uid) async {
  final firestore = FirebaseFirestore.instance;
  final today = DateTime.now();

  final userProgressRef = firestore.collection('users').doc(uid).collection('progress');
  final forestRef = firestore.collection('users').doc(uid).collection('forest');

  // 🧹 Clear old data
  for (final doc in (await userProgressRef.get()).docs) {
    await doc.reference.delete();
  }
  for (final doc in (await forestRef.get()).docs) {
    await doc.reference.delete();
  }

  final speciesCycle = [
    {'id': 'species_1', 'stages': 2},
    {'id': 'species_2', 'stages': 3},
    {'id': 'species_3', 'stages': 4},
  ];

  int speciesIndex = 0;
  int currentStage = 1;
  int growthCounter = 0;

  for (int i = 0; i < 30; i++) {
    final date = today.subtract(Duration(days: 29 - i));
    final dayStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    await userProgressRef.doc(dayStr).set({
      'date': date.toIso8601String(),
      'completed': true,
      'rewarded': true,
    });

    final species = speciesCycle[speciesIndex];
    await forestRef.add({
      'speciesId': species['id'],
      'stage': currentStage,
      'position': {
        'dx': 0.2 + 0.15 * speciesIndex + (0.05 * (growthCounter % 3)),
        'dy': 0.3 + 0.1 * (growthCounter % 2),
      },
      'plantedDate': date.toIso8601String(),
    });

    if (currentStage < (species['stages'] as int)) {
      currentStage++;
    } else {
      speciesIndex = (speciesIndex + 1) % speciesCycle.length;
      currentStage = 1;
    }

    growthCounter++;
  }

  debugPrint('✅ Seeded 30-day forest growth and progress data.');
}

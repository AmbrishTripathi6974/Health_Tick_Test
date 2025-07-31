import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/tree_model.dart';
import '../model/tree_species_model.dart';
import '../repository/tree_repository.dart';

class TreeController {
  final TreeRepository repo;
  final List<TreeSpecies> speciesList;
  final Random _random = Random();

  TreeController(this.repo, this.speciesList);

  /// Generate a random screen position (percent-based)
  Offset _generateRandomPosition() {
    return Offset(
      0.2 + _random.nextDouble() * 0.6,
      0.3 + _random.nextDouble() * 0.5,
    );
  }

  /// Grow the user's tree (either increase stage or plant new)
  Future<void> growTree(String uid, WidgetRef ref) async {
    // ❗ Prevent crash if no species loaded
    if (speciesList.isEmpty) {
      debugPrint('[TreeController] No species data available.');
      return;
    }

    List<Tree> current = await repo.fetchUserForest(uid);

    if (current.isEmpty) {
      // 🌱 First tree (Species 1, Stage 1)
      final newTree = Tree(
        speciesId: speciesList[0].id,
        stage: 1,
        position: _generateRandomPosition(),
        plantedDate: DateTime.now(),
      );
      await repo.saveUserTree(uid, newTree);
      return;
    }

    Tree last = current.last;

    // 🔍 Find matching species from list (fallback added)
    final species = speciesList.firstWhere(
      (s) => s.id == last.speciesId,
      orElse: () => TreeSpecies(
        id: last.speciesId,
        stages: 1,
        stageParams: [
          {'color': 'green', 'height': 40}
        ],
      ),
    );

    if (last.stage < species.stages) {
      // 🌿 Grow current tree to next stage
      final updated = last.copyWith(stage: last.stage + 1);
      await repo.updateTree(uid, updated);
    } else {
      // 🌳 Tree fully grown → plant next species
      final currentSpeciesIndex = speciesList.indexWhere((s) => s.id == last.speciesId);
      final nextIndex = (currentSpeciesIndex + 1) % speciesList.length;
      final nextSpecies = speciesList[nextIndex];

      final newTree = Tree(
        speciesId: nextSpecies.id,
        stage: 1,
        position: _generateRandomPosition(),
        plantedDate: DateTime.now(),
      );
      await repo.saveUserTree(uid, newTree);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/tree_model.dart';
import '../model/tree_species_model.dart';
import '../repository/tree_repository.dart';

/// Provides access to TreeRepository throughout the app
final treeRepoProvider = Provider<TreeRepository>(
  (ref) => throw UnimplementedError('Must override treeRepoProvider in main.dart'),
);

/// Fetches all tree species from Firestore
final speciesProvider = FutureProvider<List<TreeSpecies>>((ref) async {
  final repo = ref.watch(treeRepoProvider);
  return await repo.fetchSpecies();
});

/// Fetches forest (user trees) from Firestore for a given user
final forestProvider = FutureProvider.family<List<Tree>, String>((ref, uid) async {
  final repo = ref.watch(treeRepoProvider);
  return await repo.fetchUserForest(uid);
});

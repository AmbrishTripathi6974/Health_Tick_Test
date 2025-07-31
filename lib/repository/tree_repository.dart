import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';
import '../model/tree_model.dart';
import '../model/tree_species_model.dart';

class TreeRepository {
  final FirebaseFirestore firestore;

  TreeRepository(this.firestore);

  /// Fetches all tree species from Firestore
  Future<List<TreeSpecies>> fetchSpecies() async {
    final snapshot = await firestore.collection(speciesCollection).get();
    return snapshot.docs
        .map((doc) => TreeSpecies.fromJson(doc.data()))
        .toList();
  }

  /// Saves a new tree to the user's forest
  Future<void> saveUserTree(String uid, Tree tree) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection(forestCollection)
        .add(tree.toJson());
  }

  /// Updates an existing tree's growth stage
  Future<void> updateTree(String uid, Tree tree) async {
    if (tree.id == null) return;

    await firestore
        .collection('users')
        .doc(uid)
        .collection(forestCollection)
        .doc(tree.id)
        .update(tree.toJson());
  }

  /// Fetches the entire forest for a user (with document IDs)
  Future<List<Tree>> fetchUserForest(String uid) async {
    final snapshot = await firestore
        .collection('users')
        .doc(uid)
        .collection(forestCollection)
        .get();

    return snapshot.docs
        .map((doc) => Tree.fromJson(doc.data(), doc.id))
        .toList();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_progress_model.dart';
import '../repository/user_repository.dart';

final userRepoProvider = Provider((ref) => UserRepository(FirebaseFirestore.instance));

final progressProvider = FutureProvider.family<UserProgress?, String>((ref, uid) async {
  final repo = ref.watch(userRepoProvider);
  return repo.getProgress(uid, DateTime.now());
});

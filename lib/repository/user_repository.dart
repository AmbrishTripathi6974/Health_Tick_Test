import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/utils.dart';
import '../core/constants.dart';
import '../model/user_progress_model.dart';

class UserRepository {
  final FirebaseFirestore firestore;

  UserRepository(this.firestore);

  Future<void> saveProgress(String uid, UserProgress progress) async {
    final dateStr = formatDate(progress.date);

    await firestore
        .collection('users')
        .doc(uid)
        .collection(progressCollection)
        .doc(dateStr)
        .set(progress.toJson());
  }

  Future<UserProgress?> getProgress(String uid, DateTime date) async {
    final doc = await firestore
        .collection('users')
        .doc(uid)
        .collection(progressCollection)
        .doc(formatDate(date))
        .get();

    if (!doc.exists) return null;

    return UserProgress.fromJson(doc.data()!, date);
  }
}

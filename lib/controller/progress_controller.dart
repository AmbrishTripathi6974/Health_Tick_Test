import '../model/user_progress_model.dart';
import '../repository/user_repository.dart';

class ProgressController {
  final UserRepository userRepo;

  ProgressController(this.userRepo);

  Future<bool> didGrowToday(String uid) async {
    final progress = await userRepo.getProgress(uid, DateTime.now());
    return progress?.treeGrown ?? false;
  }

  Future<void> submitProgress({
    required String uid,
    required int completedTasks,
    required void Function() onGrow,
  }) async {
    final today = DateTime.now();

    if (completedTasks < 3) {
      await userRepo.saveProgress(
        uid,
        UserProgress(date: today, tasksCompleted: completedTasks, treeGrown: false),
      );
      return;
    }

    final existing = await userRepo.getProgress(uid, today);
    if (existing != null && existing.treeGrown) {
      return; // Already grown
    }

    // Grow tree
    onGrow();

    await userRepo.saveProgress(
      uid,
      UserProgress(date: today, tasksCompleted: completedTasks, treeGrown: true),
    );
  }
}

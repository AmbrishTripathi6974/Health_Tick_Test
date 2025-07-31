class UserProgress {
  final DateTime date;
  final int tasksCompleted;
  final bool treeGrown;

  UserProgress({
    required this.date,
    required this.tasksCompleted,
    required this.treeGrown,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json, DateTime date) {
    return UserProgress(
      date: date,
      tasksCompleted: json['tasksCompleted'],
      treeGrown: json['treeGrown'],
    );
  }

  Map<String, dynamic> toJson() => {
    'tasksCompleted': tasksCompleted,
    'treeGrown': treeGrown,
  };
}

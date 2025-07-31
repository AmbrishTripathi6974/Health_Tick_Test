class TreeSpecies {
  final String id;
  final int stages;
  final List<Map<String, dynamic>> stageParams;

  TreeSpecies({
    required this.id,
    required this.stages,
    required this.stageParams,
  });

  factory TreeSpecies.fromJson(Map<String, dynamic> json) {
    return TreeSpecies(
      id: json['id'],
      stages: json['stages'],
      stageParams: List<Map<String, dynamic>>.from(json['stageParams']),
    );
  }
}

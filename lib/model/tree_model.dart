import 'package:flutter/material.dart';

class Tree {
  final String? id; 
  final String speciesId;
  final int stage;
  final Offset position;
  final DateTime plantedDate;

  Tree({
    this.id,
    required this.speciesId,
    required this.stage,
    required this.position,
    required this.plantedDate,
  });

  /// ✅ From Firestore Document
  factory Tree.fromJson(Map<String, dynamic> json, String id) {
    final positionData = json['position'] ?? {};

    return Tree(
      id: id,
      speciesId: json['speciesId'] ?? '',
      stage: (json['stage'] ?? 1) as int,
      position: Offset(
        (positionData['x'] ?? 0.5).toDouble(), // fallback to center
        (positionData['y'] ?? 0.5).toDouble(),
      ),
      plantedDate: DateTime.tryParse(json['plantedDate'] ?? '') ?? DateTime.now(),
    );
  }

  /// ✅ For Firestore
  Map<String, dynamic> toJson() => {
    'speciesId': speciesId,
    'stage': stage,
    'position': {
      'x': position.dx,
      'y': position.dy,
    },
    'plantedDate': plantedDate.toIso8601String(),
  };

  /// ✅ Create updated copy (e.g., for stage increment)
  Tree copyWith({
    String? id,
    int? stage,
    Offset? position,
  }) {
    return Tree(
      id: id ?? this.id,
      speciesId: speciesId,
      stage: stage ?? this.stage,
      position: position ?? this.position,
      plantedDate: plantedDate,
    );
  }
}

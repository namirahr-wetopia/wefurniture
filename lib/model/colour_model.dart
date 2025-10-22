import '../utils/date_parser.dart';

class ColourModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  ColourModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt
  });

  factory ColourModel.fromJson(Map<String, dynamic> json) {
    return ColourModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String()
    };
  }
}

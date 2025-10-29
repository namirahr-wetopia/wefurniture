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
      createdAt: DateParser.parseToLocal(json['created_at']),
      updatedAt: DateParser.parseToLocal(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': DateParser.toUtcIso(createdAt),
      'updated_at': DateParser.toUtcIso(updatedAt)
    };
  }
}

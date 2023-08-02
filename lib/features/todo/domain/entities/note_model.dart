import '../../../../local_database.dart';

class NoteModel {
  final int id;
  final String name;
  final String color;
  final String description;
  final String time;
  final String date;

  const NoteModel({
    required this.id,
    required this.name,
    required this.color,
    required this.description,
    required this.time,
    required this.date,
  });

  NoteModel copy({
    int? id,
    String? name,
    String? color,
    String? description,
    String? time,
    String? date,
  }) =>
      NoteModel(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        description: description ?? this.description,
        time: time ?? this.time,
        date: date ?? this.date,
      );

  static NoteModel fromJson(Map<String, dynamic> json) => NoteModel(
        id: json[NoteFields.id],
        name: json[NoteFields.name],
        color: json[NoteFields.color],
        description: json[NoteFields.description],
        time: json[NoteFields.time],
        date: json[NoteFields.date],
      );

  Map<String, dynamic> toJson() => {
        NoteFields.id: id,
        NoteFields.name: name,
        NoteFields.color: color,
        NoteFields.description: description,
        NoteFields.time: time,
        NoteFields.date: date
      };
}

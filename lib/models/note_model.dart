import 'dart:convert';

class NoteItem {
  NoteItem({
     this.id,
    required this.description,
    required this.title,
    required this.crateAt,
  });

  int? id;
  String description;
  String title;
  DateTime crateAt;

  NoteItem copyWith({
    int? id,
    String? description,
    String? title,
    DateTime? crateAt,
  }) =>
      NoteItem(
        id: id ?? this.id,
        description: description ?? this.description,
        title: title ?? this.title,
        crateAt: crateAt ?? this.crateAt,
      );

  factory NoteItem.fromJson(String str) =>
      NoteItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NoteItem.fromMap(Map<String, dynamic> json) => NoteItem(
        id: json["id"],
        description: json["description"],
        title: json["title"],
        crateAt: DateTime.parse(json["crateAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "title": title,
        "crateAt": crateAt.toIso8601String(),
      };


 static List<NoteItem> noteModelFromMap(String str) => List<NoteItem>.from(json.decode(str).map((x) => NoteItem.fromMap(x)));

 static String noteModelToMap(List<NoteItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

}


import 'dart:convert';

import 'package:equatable/equatable.dart';

Notes notesFromMap(String str) => Notes.fromMap(json.decode(str));

String notesToMap(Notes data) => json.encode(data.toMap());

class Notes extends Equatable{
  final int? noteId;
  final String title;
  final String content;
  final String createdAt;

  Notes({
    this.noteId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Notes.fromMap(Map<String, dynamic> json) => Notes(
    noteId: json["noteId"],
    title: json["title"],
    content: json["content"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toMap() => {
    "noteId": noteId,
    "title": title,
    "content": content,
    "createdAt": createdAt,
  };

  @override
  List<Object?> get props => [noteId, title, content, createdAt];
}

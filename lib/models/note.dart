import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String noteId;
  final String groupId;
  final String authorId;
  final String text;
  final Timestamp dateCreated;

  Note({
    required this.noteId,
    required this.groupId,
    required this.authorId,
    required this.text,
    required this.dateCreated,
  });

  Map<String, dynamic> toJson() => {
        'noteId': noteId,
        'groupId': groupId,
        'authorId': authorId,
        'text': text,
        'dateCreated': dateCreated
      };
}

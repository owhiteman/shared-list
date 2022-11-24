import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_list/models/group.dart';
import 'package:shared_list/models/note.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserDetails() async {
    Map<String, dynamic> userDetails = {};
    try {
      var docRef = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      userDetails = docRef.data()!;
    } on Exception catch (e) {
      print(e);
    }

    return userDetails;
  }

  Future<String> createGroup(String name) async {
    String status = 'error';
    List<String> members = [];
    List<String> notes = [];
    String groupId = const Uuid().v4();
    members.add(_auth.currentUser!.uid);

    Group group = Group(
        groupId: groupId,
        name: name,
        members: members,
        groupAdminId: _auth.currentUser!.uid,
        notes: notes);

    try {
      await _firestore.collection('groups').doc(groupId).set(group.toJson());
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'groupId': groupId});
      status = 'success';
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<String> joinGroup(String groupId) async {
    String status = 'error';
    List<String> members = [];
    members.add(_auth.currentUser!.uid);
    try {
      await _firestore
          .collection('groups')
          .doc(groupId)
          .update({'members': FieldValue.arrayUnion(members)});
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'groupId': groupId});
      status = 'success';
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<Map<String, dynamic>> getGroupDetails() async {
    Map<String, dynamic> groupDetails = {};

    try {
      var userDetails = await getUserDetails();
      var groupId = userDetails['groupId'];
      var docRef = await _firestore.collection('groups').doc(groupId).get();
      groupDetails = docRef.data()!;
    } on Exception catch (e) {
      print(e);
    }

    return groupDetails;
  }

  Future<List<String>> getGroupMembers() async {
    List<String> nameList = [];
    try {
      var groupDetails = await getGroupDetails();

      for (var id in groupDetails['members']) {
        var memberData = await _firestore.collection('users').doc(id).get();

        var member = memberData.data()!;
        nameList.add(member['name']);
      }
    } on Exception catch (e) {
      print(e);
    }
    return nameList;
  }

  Future<String> createNote(String message) async {
    var status = 'error';
    try {
      var noteId = const Uuid().v4();
      var group = await getGroupDetails();
      var groupId = group['groupId'];
      var noteList = group['notes'] ?? [];
      noteList.add(noteId);

      Note note = Note(
        noteId: noteId,
        groupId: groupId,
        authorId: _auth.currentUser!.uid,
        text: message,
        dateCreated: Timestamp.now(),
      );
      await _firestore.collection('notes').doc(noteId).set(note.toJson());
      await _firestore
          .collection('groups')
          .doc(groupId)
          .update({'notes': noteList});
      status = 'success';
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<List<Map<String, dynamic>>> getGroupNotes() async {
    List<Map<String, dynamic>> notes = [];
    try {
      var groupDetails = await getGroupDetails();
      var noteIds = groupDetails['notes'];
      for (var noteId in noteIds) {
        var note = await _firestore.collection('notes').doc(noteId).get();
        var noteData = note.data()!;
        if (noteData['noteId'] != null) {
          notes.add(noteData);
        }
      }
    } catch (e) {
      print(e);
    }
    return notes;
  }

  Future<String> deleteNote(String noteId) async {
    var status = 'error';

    try {
      await _firestore.collection('notes').doc(noteId).delete();
      var groupDetails = await getGroupDetails();

      await _firestore.collection('groups').doc(groupDetails['groupId']).update(
        {
          'notes': FieldValue.arrayRemove([noteId])
        },
      );

      status = 'success';
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<String> leaveGroup() async {
    var status = 'error';

    try {
      var user = await getUserDetails();
      var group = await getGroupDetails();

      await _firestore.collection('groups').doc(group['groupId']).update({
        'members': FieldValue.arrayRemove([user['uid']])
      });
      await _firestore
          .collection('users')
          .doc(user['uid'])
          .update({'groupId': null});
      status = 'success';
    } catch (e) {
      print(e);
    }

    return status;
  }
}

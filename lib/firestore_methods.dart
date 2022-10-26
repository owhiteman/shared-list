import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_list/models/group.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserDetails() async {
    var docRef =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    return docRef.data()!;
  }

  Future<String> createGroup(String name) async {
    String status = 'error';
    List<String> members = [];
    String groupId = const Uuid().v4();
    members.add(_auth.currentUser!.uid);

    Group group = Group(
        groupId: groupId,
        name: name,
        members: members,
        groupAdminId: _auth.currentUser!.uid);

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
    var userDetails = await getUserDetails();
    var groupId = userDetails['groupId'];
    var docRef = await _firestore.collection('groups').doc(groupId).get();

    return docRef.data()!;
  }
}

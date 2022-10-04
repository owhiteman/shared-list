import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserDetails() async {
    var docRef =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

    return docRef.data()!;
  }
}

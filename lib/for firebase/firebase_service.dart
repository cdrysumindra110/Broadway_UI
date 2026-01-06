import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final usersCollection = FirebaseFirestore.instance.collection("users");

  Future<void> addUsers(Map<String, dynamic> json) async {
    try {
      await usersCollection.add(json);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

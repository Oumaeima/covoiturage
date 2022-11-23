import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  static Future<User?> AuthCredential({
    required String name,
    required String email,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = ( auth.currentUser) as UserCredential;
      user = userCredential.user;
      await user?.updateDisplayName(name);
      await user?.updateEmail(email);
      await user?.reload();
      user = auth.currentUser;
    } catch (e) {

    } catch (e) {
      print(e);
    }
    return user;
  }
}
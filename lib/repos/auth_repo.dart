import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {

  Future<String> foodLogin(
      {required String email, required String password}) async {
    log('${email.trim()} ${password.trim()}');

    final db = FirebaseFirestore.instance;

    final snapshot = await db
        .collection("Admin")
        .where("email", isEqualTo: email)
        .where("adminStatus", isEqualTo: "Food")
        .get();

    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
        log('User data fetched: ${credential.user!.uid}');

        return credential.user!.uid;
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        if (e.code == 'user-not-found') {
          throw ('No user found for the email.');
        } else if (e.code == 'wrong-password') {
          throw ('Invalid Password');
        } else {
          throw ('Login Failed');
        }
      }
    } else {
      throw ("Food account doesn't exist with entered details");
    }
  }

  Future<String> securityLogin(
      {required String email, required String password}) async {
    log('${email.trim()} ${password.trim()}');

    final db = FirebaseFirestore.instance;

    final snapshot = await db
        .collection("Admin")
        .where("email", isEqualTo: email)
        .where("adminStatus", isEqualTo: "Security")
        .get();

    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());

      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.trim(), password: password.trim());
        log('User data fetched: ${credential.user!.uid}');

        return credential.user!.uid;
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        if (e.code == 'user-not-found') {
          throw ('No user found for the email.');
        } else if (e.code == 'wrong-password') {
          throw ('Invalid Password');
        } else {
          throw ('Login Failed');
        }
      }
    } else {
      throw ("Security account doesn't exist with entered details");
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}

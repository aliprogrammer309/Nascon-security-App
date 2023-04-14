import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nascon_security_app/models/events/user_event.dart';

class HomeRepo {
  Future<List<UserEvent>> getUserDetails({required String id}) async {
    List<UserEvent> events = [];
    final db = FirebaseFirestore.instance;

    final snapshot = await db
        .collection("EventParticipants")
        .where("id", isEqualTo: id)
        .get();

    if (snapshot.docs.isNotEmpty) {
      events = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        events.add(
          UserEvent(
            name: snapshot.docs[i].data()['name'],
            ph: snapshot.docs[i].data()['phone'],
            fee: snapshot.docs[i].data()['fee'],
            eventName: snapshot.docs[i].data()['eventName'],
            cnic: snapshot.docs[i].data()['cnic'],
            email: snapshot.docs[i].data()['email'],
            status: snapshot.docs[i].data()['status'],
          ),
        );
      }
    } else {
      log('No events registered or Invalid QR Code');
    }

    return events;
  }
}

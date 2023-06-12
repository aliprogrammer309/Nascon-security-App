import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nascon_security_app/models/events/user_event.dart';

class HomeRepo {
  Future<List<UserEvent>> getUserDetails({required String id}) async {
    List<UserEvent> events = [];
    final db = FirebaseFirestore.instance;

    final snapshot = await db
        .collection("EventParticipants")
        .where("user_id", isEqualTo: id)
        .get();

    if (snapshot.docs.isNotEmpty) {
      events = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        events.add(
          UserEvent(
            docId: snapshot.docs[i].id,
            id: snapshot.docs[i].data()['user_id'],
            name: snapshot.docs[i].data()['name'],
            ph: snapshot.docs[i].data()['phone'],
            fee: snapshot.docs[i].data()['fee'],
            eventName: snapshot.docs[i].data()['eventName'],
            cnic: snapshot.docs[i].data()['cnic'],
            email: snapshot.docs[i].data()['email'],
            status: snapshot.docs[i].data()['status'],
            food_count: snapshot.docs[i].data()['food_count']
          ),
        );
      }
    } else {
      log('No events registered or Invalid QR Code');
    }

    return events;
  }

  getFoodDetails({required id}) async {
    List<UserEvent> events = [];
    final db = FirebaseFirestore.instance;

    final snapshot = await db
        .collection("EventParticipants")
        .where("user_id", isEqualTo: id)
        .get();

    if (snapshot.docs.isNotEmpty) {
      events = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        events.add(
          UserEvent(
            docId: snapshot.docs[i].id,
              id: snapshot.docs[i].data()['user_id'],
              name: snapshot.docs[i].data()['name'],
              ph: snapshot.docs[i].data()['phone'],
              fee: snapshot.docs[i].data()['fee'],
              eventName: snapshot.docs[i].data()['eventName'],
              cnic: snapshot.docs[i].data()['cnic'],
              email: snapshot.docs[i].data()['email'],
              status: snapshot.docs[i].data()['status'],
              food_count: snapshot.docs[i].data()['food_count']
          ),
        );
      }

      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      for (int i = 0; i < events.length; i++) {
        final event = events[i];
        final docRef = db.collection("EventParticipants").doc(event.docId); // Assuming you have an 'id' field in UserEvent class

        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          batch.update(docRef, {"food_count": event.food_count - 1});
        } else {
          print("Document not found for ID: ${event.id}");
        }
      }

      batch.commit();

    } else {
      log('No events registered or Invalid QR Code');
    }

    return events[0];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../domain/booking_request.dart';

class BookingRepository {
  BookingRepository({FirebaseFirestore? firestore}) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  Future<void> save(BookingRequest request) async {
    if (Firebase.apps.isEmpty) {
      throw const FirebaseNotConfiguredException();
    }

    final firestore = _firestore ?? FirebaseFirestore.instance;
    await firestore.collection('booking_requests').add(request.toFirestore());
  }
}

class FirebaseNotConfiguredException implements Exception {
  const FirebaseNotConfiguredException();
}

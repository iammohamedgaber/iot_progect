import 'package:firebase_database/firebase_database.dart';

class SessionService {
  final DatabaseReference fire_base = FirebaseDatabase.instance.ref();

  Future<void> openSession(String sessionId, String week) async {
    await fire_base.child("current_session").set({
      "session_id": sessionId,
      "number_of_week": week,
      "status": true,
    });
  }

  Future<void> closeSession() async {
    await fire_base.child("current_session/status").set(false);
  }

  Future<String?> getCurrentSessionId() async {
    final snapshot = await fire_base.child("current_session/session_id").get();
    return snapshot.exists ? snapshot.value.toString() : null;
  }

  Future<bool> isSessionOpen() async {
    final snapshot = await fire_base.child("current_session/status").get();
    return snapshot.value == true;
  }

  Future<String?> getCurrentWeek() async {
    final snapshot = await fire_base
        .child("current_session/number_of_week")
        .get();
    return snapshot.exists ? snapshot.value.toString() : null;
  }

  Future<void> updateCurrentWeek(String week) async {
    await fire_base.child("current_session/number_of_week").set(week);
  }
}

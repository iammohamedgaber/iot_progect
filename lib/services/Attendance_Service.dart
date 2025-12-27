import 'package:firebase_database/firebase_database.dart';
import '../models/attendance_model.dart';

class AttendanceService {
  String decryptData(String? obfuscated) {
    if (obfuscated == null || obfuscated.isEmpty) return "";

    String original = "";
    for (int i = 0; i < obfuscated.length; i += 3) {
      original += obfuscated[i];
    }

    return original;
  }

  final DatabaseReference fire_base = FirebaseDatabase.instance.ref();

  Future<List<AttendanceModel>> getStudentsBySession(String sessionId) async {
    final snapshot = await fire_base.child("root/attendance/$sessionId").get();
    if (!snapshot.exists || snapshot.value == null) return [];

    final Map<dynamic, dynamic> studentMap = Map<dynamic, dynamic>.from(
      snapshot.value as Map,
    );

    final List<AttendanceModel> students = [];
    studentMap.forEach((uidHex, data) {
      if (data is Map) {
        students.add(
          AttendanceModel.fromMap(
            Map<dynamic, dynamic>.from(data),
            sessionId,
            uidHex.toString(),
          ),
        );
      }
    });
    return students;
  }

 
  Future<void> clearStudentsBySession(String sessionId) async {
    final snapshot = await fire_base.child("root/attendance/$sessionId").get();
    if (!snapshot.exists || snapshot.value == null) return;

    final Map<dynamic, dynamic> studentMap = Map<dynamic, dynamic>.from(
      snapshot.value as Map,
    );

    for (var uid in studentMap.keys) {
      await fire_base.child("root/attendance/$sessionId/$uid").remove();
    }
  }
}

import '../utils/decrypt_utils.dart';
class AttendanceModel {
  final String sessionId;
  final String id;
  final String name;
  final String time;
  final String uidHex;
  final String week;
  AttendanceModel({
    required this.sessionId,
    required this.week,
    required this.id,
    required this.name,
    required this.time,
    required this.uidHex,
  });
  factory AttendanceModel.fromMap(
    Map<dynamic, dynamic> data,
    String sessionId,
    String uidHex,
  ) {
    return AttendanceModel(
      sessionId: sessionId,
      week: decryptData(data['week']?.toString()),
      id: decryptData(data['id']?.toString()),
      name: decryptData(data['name']?.toString()),
      time: decryptData(data['time']?.toString()),
      uidHex: decryptData(uidHex),
    );
  }
}

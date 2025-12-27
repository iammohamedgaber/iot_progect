import 'package:bloc/bloc.dart';
import 'package:iotproject/services/Attendance_Service.dart';

import '../models/attendance_model.dart';

import 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceService _attendanceService;
  List<AttendanceModel> students = [];
  String? selectedSessionId;

  final Map<String, String> subjects = {
    "Mobile_programming": "Mobile_programming",
    "IoT_Programmin": "IoT_Programmin",
    "Artificial_Intelligenc": "Artificial_Intelligenc",
    "windows_programming": "windows_programming",
    "signal_processing": "signal_processing",
    "Ccan_2": "Ccan_2",
  };

  AttendanceCubit({required AttendanceService service})
    : _attendanceService = service,
      super(
        AttendanceSubjectsLoaded({
          "Mobile_programming": "Mobile_programming",
          "IoT_Programmin": "IoT_Programmin",
          "Artificial_Intelligenc": "Artificial_Intelligenc",
          "windows_programming": "windows_programming",
          "signal_processing": "signal_processing",
          "Ccan_2": "Ccan_2",
        }, "Mobile_programming"),
      ) {
    selectedSessionId = "Mobile_programming";
  }

  void setSelectedSession(String sessionId) {
    selectedSessionId = sessionId;
    emit(AttendanceSubjectsLoaded(subjects, selectedSessionId));
  }

  Future<void> loadStudents(String sessionId) async {
    emit(AttendanceLoading());
    try {
      students = await _attendanceService.getStudentsBySession(sessionId);
      emit(AttendanceLoaded(students));
    } catch (e) {
      emit(AttendanceError("حدث خطأ أثناء تحميل الطلاب: ${e.toString()}"));
    }
  }

  Future<void> clearStudents(String sessionId) async {
    try {
      await _attendanceService.clearStudentsBySession(sessionId);
      students.clear();
      emit(AttendanceLoaded(students));
    } catch (e) {
      emit(AttendanceError("حدث خطأ أثناء مسح الطلاب: ${e.toString()}"));
    }
  }
}

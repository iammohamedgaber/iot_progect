import '../models/attendance_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceModel> students;
  AttendanceLoaded(this.students);
}


class AttendanceSubjectsLoaded extends AttendanceState {
  final Map<String, String> subjects; 
  final String? selectedSessionId;

  AttendanceSubjectsLoaded(this.subjects, this.selectedSessionId);
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}

class SharedAttendanceData {
  static final SharedAttendanceData _instance = SharedAttendanceData._internal();

  factory SharedAttendanceData() {
    return _instance;
  }

  SharedAttendanceData._internal();

  // SectionName → Date → StudentName → Present/Absent
  Map<String, Map<DateTime, Map<String, bool>>> attendanceRecords = {};
}

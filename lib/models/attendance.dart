enum AttendanceStatus { present, absent, late }

class AttendanceLog {
  final String id;
  final DateTime date;
  final DateTime? clockIn;
  final DateTime? clockOut;
  final AttendanceStatus status;
  final String? location;

  AttendanceLog({
    required this.id,
    required this.date,
    this.clockIn,
    this.clockOut,
    required this.status,
    this.location,
  });

  double get totalHours {
    if (clockIn == null || clockOut == null) return 0;
    return clockOut!.difference(clockIn!).inMinutes / 60.0;
  }
}

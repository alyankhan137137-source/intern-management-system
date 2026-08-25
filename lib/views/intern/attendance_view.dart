import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/attendance.dart';
import 'package:intern_management_system/services/app_repository.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  final _repository = AppRepository();
  bool _isClockedIn = false;
  DateTime? _startTime;
  Timer? _timer;
  String _elapsedTime = '00:00:00';

  void _toggleClock() {
    setState(() {
      _isClockedIn = !_isClockedIn;
      if (_isClockedIn) {
        _startTime = DateTime.now();
        _startTimer();
      } else {
        _stopTimer();
        // Add log to repository
        _repository.addAttendanceLog(AttendanceLog(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          date: DateTime.now(),
          clockIn: _startTime,
          clockOut: DateTime.now(),
          status: AttendanceStatus.present,
          location: 'Remote',
        ));
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        final duration = DateTime.now().difference(_startTime!);
        setState(() {
          _elapsedTime = _formatDuration(duration);
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _elapsedTime = '00:00:00';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Clock Section
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.containerRadius,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _elapsedTime,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _isClockedIn ? 'YOU ARE CURRENTLY CLOCKED IN' : 'YOU ARE CLOCKED OUT',
                  style: TextStyle(color: _isClockedIn ? AppColors.success : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _toggleClock,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isClockedIn ? AppColors.error : AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
                    ),
                    child: Text(_isClockedIn ? 'CLOCK OUT' : 'CLOCK IN NOW'),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.xxl),
          
          // History Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Logs', style: Theme.of(context).textTheme.headlineSmall),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ..._repository.attendanceHistory.map((log) => _buildLogItem(log)),
        ],
      ),
    );
  }

  Widget _buildLogItem(AttendanceLog log) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardRadius,
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: AppColors.success.withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.check, color: AppColors.success, size: 20),
        ),
        title: Text('${log.date.day}/${log.date.month}/${log.date.year}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${log.totalHours.toStringAsFixed(1)} hours logged • ${log.location}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

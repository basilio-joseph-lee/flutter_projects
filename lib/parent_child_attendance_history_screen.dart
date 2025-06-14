import 'package:flutter/cupertino.dart';
import 'shared_attendance_data.dart';

class ParentChildAttendanceHistoryScreen extends StatelessWidget {
  final String childName;

  const ParentChildAttendanceHistoryScreen({super.key, required this.childName});

  @override
  Widget build(BuildContext context) {
    // Collect attendance records for this child across all sections
    final Map<DateTime, bool> childAttendance = {};

    SharedAttendanceData().attendanceRecords.forEach((section, dates) {
      dates.forEach((date, studentMap) {
        if (studentMap.containsKey(childName)) {
          childAttendance[date] = studentMap[childName]!;
        }
      });
    });

    // Sort dates (latest first)
    final sortedDates = childAttendance.keys.toList()..sort((a, b) => b.compareTo(a));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('$childName - Attendance History'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chevron_down),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: sortedDates.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(CupertinoIcons.calendar, size: 80, color: CupertinoColors.systemGrey),
              SizedBox(height: 16),
              Text(
                'No attendance records yet.',
                style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
              ),
            ],
          ),
        )
            : ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: sortedDates.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final date = sortedDates[index];
            final isPresent = childAttendance[date]!;

            return Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${date.month}/${date.day}/${date.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        isPresent
                            ? CupertinoIcons.check_mark_circled_solid
                            : CupertinoIcons.clear_circled_solid,
                        color: isPresent
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.systemRed,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isPresent ? 'Present' : 'Absent',
                        style: TextStyle(
                          fontSize: 16,
                          color: isPresent
                              ? CupertinoColors.activeGreen
                              : CupertinoColors.systemRed,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

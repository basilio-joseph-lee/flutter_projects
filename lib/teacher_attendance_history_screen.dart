import 'package:flutter/cupertino.dart';
import 'shared_attendance_data.dart';

class TeacherAttendanceHistoryScreen extends StatelessWidget {
  final String sectionName;

  const TeacherAttendanceHistoryScreen({super.key, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    final sectionRecords = SharedAttendanceData().attendanceRecords[sectionName] ?? {};

    // Sort dates descending (latest first)
    final sortedDates = sectionRecords.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('$sectionName - History'),
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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.time,
                  size: 80,
                  color: CupertinoColors.systemGrey,
                ),
                SizedBox(height: 16),
                Text(
                  'No attendance records yet for this section.',
                  style: TextStyle(
                    fontSize: 18,
                    color: CupertinoColors.systemGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
            : ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: sortedDates.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final date = sortedDates[index];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AttendanceSummaryScreen(
                      sectionName: sectionName,
                      date: date,
                    ),
                  ),
                );
              },
              child: Container(
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
                    const Icon(CupertinoIcons.chevron_forward),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

  }
}

class AttendanceSummaryScreen extends StatelessWidget {
  final String sectionName;
  final DateTime date;

  const AttendanceSummaryScreen({super.key, required this.sectionName, required this.date});

  @override
  Widget build(BuildContext context) {
    final studentRecords =
        SharedAttendanceData().attendanceRecords[sectionName]?[date] ?? {};

    // Sort students alphabetically
    final sortedStudents = studentRecords.keys.toList()..sort();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('$sectionName - ${date.month}/${date.day}/${date.year}'),
      ),
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: sortedStudents.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final studentName = sortedStudents[index];
            final isPresent = studentRecords[studentName] ?? false;

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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      studentName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(
                    isPresent
                        ? CupertinoIcons.checkmark_circle_fill
                        : CupertinoIcons.clear_circled_solid,
                    color: isPresent
                        ? CupertinoColors.activeGreen
                        : CupertinoColors.systemRed,
                    size: 24,
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

import 'package:flutter/cupertino.dart';
import 'shared_attendance_data.dart';

class ParentChildAttendanceHistoryScreen extends StatelessWidget {
  final String childName;

  const ParentChildAttendanceHistoryScreen({super.key, required this.childName});

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, bool> childAttendance = {};

    SharedAttendanceData().attendanceRecords.forEach((section, dates) {
      dates.forEach((date, studentMap) {
        if (studentMap.containsKey(childName)) {
          childAttendance[date] = studentMap[childName]!;
        }
      });
    });

    final sortedDates = childAttendance.keys.toList()..sort((a, b) => b.compareTo(a));

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Corkboard background
          Positioned.fill(
            child: Image.asset(
              'assets/images/corkboard.png',
              fit: BoxFit.cover,
            ),
          ),

          // Custom navigation bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        CupertinoIcons.chevron_left,
                        color: CupertinoColors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        '$childName - Attendance History',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                          shadows: [
                            Shadow(
                              color: CupertinoColors.black,
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24), // spacer to balance back button
                  ],
                ),
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: sortedDates.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.calendar,
                      size: 80,
                      color: CupertinoColors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No attendance records yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                        shadows: [
                          Shadow(
                            color: CupertinoColors.black,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
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

                  final Color bgColor = isPresent
                      ? const Color(0xFFCAF7E3)
                      : const Color(0xFFFFC1C1);

                  return Container(
                    decoration: BoxDecoration(
                      color: bgColor.withOpacity(0.9),
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
          ),
        ],
      ),
    );
  }
}

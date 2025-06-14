import 'package:flutter/cupertino.dart';
import 'teacher_attendance_entry_screen.dart';
import 'teacher_attendance_history_screen.dart';

class TeacherAttendanceSectionListScreen extends StatelessWidget {
  const TeacherAttendanceSectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example Section List
    List<String> sections = [
      'Grade 7 - Diamond',
      'Grade 8 - Emerald',
      'Grade 9 - Sapphire',
      'Grade 10 - Topaz',
      'Grade 11 - Amethyst',
      'Grade 12 - Pearl',
    ];

    // Section colors (optional → for visual variety)
    List<Color> sectionColors = [
      CupertinoColors.systemPurple,
      CupertinoColors.systemGreen,
      CupertinoColors.systemBlue,
      CupertinoColors.systemOrange,
      CupertinoColors.systemPink,
      CupertinoColors.systemIndigo,
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Attendance - Sections'),
      ),
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: sections.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section Button → Attendance Entry
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TeacherAttendanceEntryScreen(
                          sectionName: sections[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: sectionColors[index % sectionColors.length].withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: sectionColors[index % sectionColors.length].withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.person_3_fill,
                          size: 40,
                          color: CupertinoColors.white,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            sections[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.chevron_forward,
                          color: CupertinoColors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // View Attendance History Button → small with icon
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  color: CupertinoColors.systemGrey4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(CupertinoIcons.time, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'View Attendance History',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TeacherAttendanceHistoryScreen(
                          sectionName: sections[index],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

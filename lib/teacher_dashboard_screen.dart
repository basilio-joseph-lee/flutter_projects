import 'package:flutter/cupertino.dart';
import 'seat_map_screen.dart';
import 'teacher_grades_section_list_screen.dart';
import 'teacher_attendance_section_list_screen.dart';
import 'shared_seat_data.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/corkboard.png',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Custom Navigation Bar added here
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
                    const SizedBox(width: 24),
                    const Expanded(
                      child: Text(
                        'Teacher Dashboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
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
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        CupertinoIcons.power,
                        color: CupertinoColors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 90),

                  const SizedBox(height: 30),

                  // Dashboard Grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        // View Seat Map
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: dashboardCard(
                            icon: CupertinoIcons.person_3_fill,
                            label: 'View Seat Map',
                            color: const Color(0xFFCAF7E3), // Light green
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    SeatMapScreen(seats: SharedSeatData().seats),
                              ),
                            );
                          },
                        ),

                        // Attendance
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: dashboardCard(
                            icon: CupertinoIcons.checkmark_seal_fill,
                            label: 'Attendance',
                            color: const Color(0xFFFFF3B0), // Light yellow
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                const TeacherAttendanceSectionListScreen(),
                              ),
                            );
                          },
                        ),

                        // Announcements
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: dashboardCard(
                            icon: CupertinoIcons.news_solid,
                            label: 'Announcements',
                            color: const Color(0xFFFFE8D6), // Light orange
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                const TeacherAnnouncementsScreen(),
                              ),
                            );
                          },
                        ),

                        // Grades
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: dashboardCard(
                            icon: CupertinoIcons.chart_bar_alt_fill,
                            label: 'Grades',
                            color: const Color(0xFFE4C1F9), // Light purple
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                const TeacherGradesSectionListScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dashboardCard({required IconData icon, required String label, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: CupertinoColors.black, size: 50),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



  Widget dashboardCard({required IconData icon, required String label, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: CupertinoColors.white, size: 50),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

// Logout Button in AppBar
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.power),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}


// Improved Teacher Announcements Screen
class TeacherAnnouncementsScreen extends StatefulWidget {
  const TeacherAnnouncementsScreen({super.key});

  @override
  State<TeacherAnnouncementsScreen> createState() => _TeacherAnnouncementsScreenState();
}

class _TeacherAnnouncementsScreenState extends State<TeacherAnnouncementsScreen> {
  final List<Announcement> announcements = [
    Announcement(title: 'Exam Week', date: 'July 5, 2025'),
    Announcement(title: 'Project Submission', date: 'July 10, 2025'),
    Announcement(title: 'Holiday - No Classes', date: 'July 15, 2025'),
    Announcement(title: 'School Orientation', date: 'July 20, 2025'),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Corkboard Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/corkboard.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Custom Navigation Bar with Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.back, color: CupertinoColors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          'Teacher Announcements',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
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
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(CupertinoIcons.add, color: CupertinoColors.white),
                        onPressed: _showAddAnnouncementDialog,
                      ),
                    ],
                  ),
                ),

                // Announcement List
                Expanded(
                  child: announcements.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(CupertinoIcons.news, size: 80, color: CupertinoColors.white),
                        SizedBox(height: 16),
                        Text(
                          'No announcements yet.',
                          style: TextStyle(
                            fontSize: 18,
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: CupertinoColors.black,
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: announcements.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final announcement = announcements[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3C2), // light cork-inspired color
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              CupertinoIcons.news_solid,
                              size: 32,
                              color: CupertinoColors.white,
                              shadows: [
                                Shadow(
                                  color: CupertinoColors.black,
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    announcement.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    announcement.date,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _showAddAnnouncementDialog() {
    final TextEditingController titleController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Add Announcement'),
          content: Column(
            children: [
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: titleController,
                placeholder: 'Announcement Title',
              ),
              const SizedBox(height: 12),
              CupertinoButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Date: ${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 250,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: selectedDate,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              selectedDate = newDate;
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Add'),
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  setState(() {
                    announcements.add(
                      Announcement(
                        title: titleController.text.trim(),
                        date: '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                      ),
                    );
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

// Announcement model
class Announcement {
  final String title;
  final String date;

  Announcement({required this.title, required this.date});
}

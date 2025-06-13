import 'package:flutter/cupertino.dart';
import 'seat_map_screen.dart';
import 'teacher_grades_section_list_screen.dart';


class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example seat data (you can connect this to real database later)
    List<SeatData> seats = [
      SeatData(studentName: 'John Doe', isPresent: true),
      SeatData(studentName: 'Jane Smith', isPresent: true),
      SeatData(studentName: 'Mark Johnson', isPresent: false),
      SeatData(studentName: 'Lisa Brown', isPresent: true),
      SeatData(studentName: 'Chris Lee', isPresent: false),
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Teacher Dashboard'),
        trailing: LogoutButton(),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 20),

              const Text(
                'Welcome, Teacher!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

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
                        color: CupertinoColors.activeGreen,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SeatMapScreen(seats: seats),
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
                        color: CupertinoColors.systemBlue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const TeacherAnnouncementsScreen(),
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
                        color: CupertinoColors.systemOrange,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const TeacherGradesSectionListScreen(),
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
    );
  }

  // Reusable Dashboard Card
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

// Simple Announcements Screen (you can improve later)
class TeacherAnnouncementsScreen extends StatelessWidget {
  const TeacherAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Teacher Announcements'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Text('• Exam Week - July 5', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('• Project Submission - July 10', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('• Holiday - July 15', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// Simple Grades Screen (you can improve later)
class TeacherGradesScreen extends StatelessWidget {
  const TeacherGradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Teacher Grades'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            Text('• John Doe: 90', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('• Jane Smith: 88', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text('• Mark Johnson: 85', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

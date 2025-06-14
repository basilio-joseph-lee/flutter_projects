import 'package:flutter/cupertino.dart';
import 'seat_map_screen.dart';
import 'shared_data.dart';
import 'shared_seat_data.dart';
import 'parent_child_attendance_history_screen.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  int selectedIndex = 0;
  final CupertinoTabController tabController = CupertinoTabController(); // Add this

  // Example child seat data
  SeatData childSeat = SharedSeatData().seats.firstWhere(
        (seat) => seat.studentName == 'John Doe',
    orElse: () => SeatData(studentName: 'Unknown', isPresent: false),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController, // Add this
      tabBar: CupertinoTabBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            label: 'Grades',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return buildDashboardTab();
          case 1:
            return buildAnnouncementsTab();
          case 2:
            return buildGradesTab();
          case 3:
            return buildSettingsTab();
          default:
            return buildDashboardTab();
        }
      },
    );
  }

  Widget buildDashboardTab() {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Parent Dashboard'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // Child Status
              Container(
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
                  children: [
                    Icon(
                      childSeat.isPresent
                          ? CupertinoIcons.check_mark_circled_solid
                          : CupertinoIcons.clear_circled_solid,
                      color: childSeat.isPresent
                          ? CupertinoColors.activeGreen
                          : CupertinoColors.systemRed,
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${childSeat.studentName} is currently ${childSeat.isPresent ? "Present" : "Absent / On Break"}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
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
                    // View Attendance History
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: dashboardCard(
                        icon: CupertinoIcons.time,
                        label: 'Attendance History',
                        color: CupertinoColors.systemIndigo,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ParentChildAttendanceHistoryScreen(
                              childName: childSeat.studentName,
                            ),
                          ),
                        );
                      },
                    ),

                    // View Full Seat Map
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
                            builder: (context) => SeatMapScreen(
                              seats: SharedSeatData().seats,
                            ),
                          ),
                        );
                      },
                    ),

                    // View Grades
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: dashboardCard(
                        icon: CupertinoIcons.chart_bar_alt_fill,
                        label: 'Grades',
                        color: CupertinoColors.systemOrange,
                      ),
                      onPressed: () {
                        tabController.index = 2; // Correct way → change tab
                      },
                    ),

                    // View Announcements
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: dashboardCard(
                        icon: CupertinoIcons.news_solid,
                        label: 'Announcements',
                        color: CupertinoColors.systemBlue,
                      ),
                      onPressed: () {
                        tabController.index = 1; // Correct way → change tab
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

  Widget buildAnnouncementsTab() {
    final announcements = SharedData().announcements;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Announcements'),
      ),
      child: SafeArea(
        child: announcements.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(CupertinoIcons.news, size: 80, color: CupertinoColors.systemGrey),
              SizedBox(height: 16),
              Text(
                'No announcements yet.',
                style: TextStyle(fontSize: 18, color: CupertinoColors.systemGrey),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    CupertinoIcons.news_solid,
                    size: 32,
                    color: CupertinoColors.systemBlue,
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
    );
  }

  Widget buildGradesTab() {
    final grades = SharedData().grades;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Grades'),
      ),
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: grades.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = grades.entries.elementAt(index);
            final subject = entry.key;
            final grade = entry.value;

            Color gradeColor;
            if (grade >= 90) {
              gradeColor = CupertinoColors.activeGreen;
            } else if (grade >= 80) {
              gradeColor = CupertinoColors.systemOrange;
            } else {
              gradeColor = CupertinoColors.systemRed;
            }

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
                    subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.circle_filled,
                        color: gradeColor,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$grade',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: gradeColor,
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

  Widget buildSettingsTab() {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoButton.filled(
            child: const Text('Logout'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}

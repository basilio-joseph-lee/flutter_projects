import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final CupertinoTabController tabController = CupertinoTabController();

  bool _notificationsEnabled = true;

  SeatData childSeat = SharedSeatData().seats.firstWhere(
        (seat) => seat.studentName == 'John Doe',
    orElse: () => SeatData(studentName: 'Unknown', isPresent: false),
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: tabController,
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
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/corkboard.png',
              fit: BoxFit.cover,
            ),
          ),
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
                        'Parent Dashboard',
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey2.withOpacity(0.3),
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
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        dashboardButton(
                          icon: CupertinoIcons.time,
                          label: 'Attendance History',
                          color: const Color(0xFFD1E8FF),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ParentChildAttendanceHistoryScreen(
                                      childName: childSeat.studentName,
                                    ),
                              ),
                            );
                          },
                        ),
                        dashboardButton(
                          icon: CupertinoIcons.person_3_fill,
                          label: 'View Seat Map',
                          color: const Color(0xFFCAF7E3),
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
                        dashboardButton(
                          icon: CupertinoIcons.chart_bar_alt_fill,
                          label: 'Grades',
                          color: const Color(0xFFFFE8D6),
                          onPressed: () {
                            tabController.index = 2;
                          },
                        ),
                        dashboardButton(
                          icon: CupertinoIcons.news_solid,
                          label: 'Announcements',
                          color: const Color(0xFFE4C1F9),
                          onPressed: () {
                            tabController.index = 1;
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

  // Announcement and Grades tab code to match back button style
  Widget buildAnnouncementsTab() {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/corkboard.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.chevron_left,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () => tabController.index = 0,
                      ),
                      const Expanded(
                        child: Text(
                          'Announcements',
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
                      const SizedBox(width: 24), // spacer to balance back button
                    ],
                  ),
                ),
                const SizedBox(height: 290),
                const Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'No announcements yet.',
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGradesTab() {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/corkboard.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.chevron_left,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () => tabController.index = 0,
                      ),
                      const Expanded(
                        child: Text(
                          'Grades',
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
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
                const SizedBox(height:290),
                const Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Grades will be shown here.',
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
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget buildSettingsTab() {
    return StatefulBuilder(
      builder: (context, setState) {
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
                          onPressed: () => tabController.index = 0,
                        ),
                        const Expanded(
                          child: Text(
                            'Settings',
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
                        const SizedBox(width: 24), // Spacer to balance back button
                      ],
                    ),
                  ),
                ),
              ),

              // Foreground content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Enable Notifications',
                              style: TextStyle(fontSize: 18),
                            ),
                            CupertinoSwitch(
                              value: _notificationsEnabled,
                              onChanged: (bool value) {
                                setState(() {
                                  _notificationsEnabled = value;
                                });
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
      },
    );
  }



  Widget dashboardButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.3),
              blurRadius: 6,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

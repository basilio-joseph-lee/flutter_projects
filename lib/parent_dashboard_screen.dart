import 'package:flutter/cupertino.dart';
import 'seat_map_screen.dart';
import 'shared_data.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  int selectedIndex = 0;

  // Example child seat data
  SeatData childSeat = SeatData(studentName: 'John Doe', isPresent: true);

  // Example list of all seats
  List<SeatData> seats = [
    SeatData(studentName: 'John Doe', isPresent: true),
    SeatData(studentName: 'Jane Smith', isPresent: true),
    SeatData(studentName: 'Mark Johnson', isPresent: false),
    SeatData(studentName: 'Lisa Brown', isPresent: true),
    SeatData(studentName: 'Chris Lee', isPresent: false),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
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

              const SizedBox(height: 20),

              // Child Status
              Text(
                '${childSeat.studentName} is currently ${childSeat.isPresent ? "Present" : "Absent / On Break"}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // View Full Seat Map
              CupertinoButton.filled(
                child: const Text('View Full Seat Map'),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SeatMapScreen(
                        seats: seats,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: announcements
              .map((announcement) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('• $announcement', style: const TextStyle(fontSize: 16)),
          ))
              .toList(),
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: grades.entries
              .map((entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('• ${entry.key}: ${entry.value}', style: const TextStyle(fontSize: 16)),
          ))
              .toList(),
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

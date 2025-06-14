import 'package:flutter/cupertino.dart';
import 'seat_map_screen.dart';
import 'shared_data.dart';
import 'shared_seat_data.dart';

class KioskMainMenu extends StatefulWidget {
  final String studentName;

  const KioskMainMenu({super.key, required this.studentName});

  @override
  State<KioskMainMenu> createState() => _KioskMainMenuState();
}

class _KioskMainMenuState extends State<KioskMainMenu> {
  // Example seat data → in real app this will come from database
  List<SeatData> seats = [
    SeatData(studentName: 'John Doe', isPresent: false),
    SeatData(studentName: 'Jane Smith', isPresent: true),
    SeatData(studentName: 'Mark Johnson', isPresent: false),
    SeatData(studentName: 'Lisa Brown', isPresent: true),
    SeatData(studentName: 'Chris Lee', isPresent: false),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Welcome, ${widget.studentName}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.power),
          onPressed: () {
            Navigator.pop(context); // Go back to login screen (Logout)
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 20),

              // Example: Small Seat Map Preview (placeholder now)
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Seat Map Preview',
                    style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Action Buttons Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [

                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: kioskActionCard(
                        icon: CupertinoIcons.checkmark_seal_fill,
                        label: 'Mark Attendance',
                        color: CupertinoColors.activeGreen,
                      ),
                      onPressed: () {
                        markAttendance();
                      },
                    ),

                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: kioskActionCard(
                        icon: CupertinoIcons.person_crop_rectangle,
                        label: 'Go to Restroom',
                        color: CupertinoColors.systemYellow,
                      ),
                      onPressed: () {
                        // TODO: Handle Restroom action
                      },
                    ),

                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: kioskActionCard(
                        icon: CupertinoIcons.cart_fill,
                        label: 'Buy Snack',
                        color: CupertinoColors.systemOrange,
                      ),
                      onPressed: () {
                        // TODO: Handle Snack action
                      },
                    ),

                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: kioskActionCard(
                        icon: CupertinoIcons.time,
                        label: 'Take a Break',
                        color: CupertinoColors.systemPurple,
                      ),
                      onPressed: () {
                        // TODO: Handle Break action
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // View Seat Map button
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child: const Text('View Seat Map'),
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

              const SizedBox(height: 20),

              // Logout button
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                child: const Text('Logout'),
                onPressed: () {
                  Navigator.pop(context); // Return to login screen
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Function to mark attendance
  void markAttendance() {
    setState(() {
      for (var seat in seats) {
        if (seat.studentName == widget.studentName) {
          seat.isPresent = true;
        }
      }
    });
  }

  // Reusable Card for Actions
  Widget kioskActionCard({required IconData icon, required String label, required Color color}) {
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

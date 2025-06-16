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
      backgroundColor: CupertinoColors.systemGroupedBackground,
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
                    const SizedBox(width: 24),
                    Expanded(
                      child: Text(
                        'Welcome, ${widget.studentName}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 10),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: CupertinoColors.systemGrey),
                    ),
                    child: const Center(
                      child: Text(
                        'Seat Map Preview',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _buildActionCard(
                          icon: CupertinoIcons.checkmark_seal_fill,
                          label: 'Mark Attendance',
                          color: const Color(0xFFCAF7E3), // Light green
                          onTap: markAttendance,
                        ),
                        _buildActionCard(
                          icon: CupertinoIcons.person_crop_rectangle,
                          label: 'Go to Restroom',
                          color: const Color(0xFFFFF3B0), // Light yellow
                          onTap: () {},
                        ),
                        _buildActionCard(
                          icon: CupertinoIcons.cart_fill,
                          label: 'Buy Snack',
                          color: const Color(0xFFFFE8D6), // Light orange
                          onTap: () {},
                        ),
                        _buildActionCard(
                          icon: CupertinoIcons.time,
                          label: 'Take a Break',
                          color: const Color(0xFFE4C1F9), // Light purple
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildWideButton(
                    label: 'View Seat Map',
                    color1: const Color(0xFFD1E8FF),
                    color2: const Color(0xFFB5D5F3),
                    textColor: CupertinoColors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => SeatMapScreen(seats: seats),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildWideButton(
                    label: 'Logout',
                    color1: const Color(0xFFFFC1C1),
                    color2: const Color(0xFFFF8888),
                    textColor: CupertinoColors.black,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void markAttendance() {
    setState(() {
      for (var seat in seats) {
        if (seat.studentName == widget.studentName) {
          seat.isPresent = true;
        }
      }
    });
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: CupertinoColors.black, size: 48),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideButton({
    required String label,
    required Color color1,
    required Color color2,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color2.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 14),
        borderRadius: BorderRadius.circular(16),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class SeatMapScreen extends StatelessWidget {
  final List<SeatData> seats;

  const SeatMapScreen({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Seating Plan'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Seat Grid
              Expanded(
                child: GridView.builder(
                  itemCount: seats.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Adjust number of columns as needed
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final seat = seats[index];
                    return SeatCard(
                      studentName: seat.studentName,
                      isPresent: seat.isPresent,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeatCard extends StatelessWidget {
  final String studentName;
  final bool isPresent;

  const SeatCard({
    super.key,
    required this.studentName,
    required this.isPresent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPresent ? CupertinoColors.activeGreen : CupertinoColors.systemGrey4,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar Icon
          Icon(
            isPresent
                ? CupertinoIcons.person_crop_circle_fill
                : CupertinoIcons.person_crop_circle_badge_xmark,
            size: 50,
            color: CupertinoColors.white,
          ),

          const SizedBox(height: 12),

          // Name Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              studentName,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class SeatData {
  final String studentName;
  bool isPresent;

  SeatData({required this.studentName, required this.isPresent});
}

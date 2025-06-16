import 'package:flutter/cupertino.dart';
import 'shared_data.dart';
import 'shared_seat_data.dart';

class SeatMapScreen extends StatefulWidget {
  final List<SeatData> seats;

  const SeatMapScreen({super.key, required this.seats});

  @override
  State<SeatMapScreen> createState() => _SeatMapScreenState();
}

class _SeatMapScreenState extends State<SeatMapScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<SeatData> filteredSeats = widget.seats.where((seat) {
      return seat.studentName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

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
              child: SizedBox(
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back button
                    Positioned(
                      left: 16,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          CupertinoIcons.chevron_left,
                          color: CupertinoColors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    // Centered title
                    const Text(
                      'Seating Plan',
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
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CupertinoSearchTextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      placeholder: 'Search student name',
                      backgroundColor: CupertinoColors.white.withOpacity(0.8),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Seat Grid
                  Expanded(
                    child: GridView.builder(
                      itemCount: filteredSeats.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        final seat = filteredSeats[index];
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
        ],
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
    final Color cardColor = isPresent
        ? const Color(0xFFCAF7E3) // Light green
        : const Color(0xFFFFE5E5); // Light pink

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
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
          Icon(
            isPresent
                ? CupertinoIcons.person_crop_circle_fill
                : CupertinoIcons.person_crop_circle_badge_xmark,
            size: 50,
            color: CupertinoColors.black,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              studentName,
              style: const TextStyle(
                color: CupertinoColors.black,
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

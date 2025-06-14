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
    // Filtered seat list based on search
    List<SeatData> filteredSeats = widget.seats.where((seat) {
      return seat.studentName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Seating Plan'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              // Page Header
              const Text(
                'Classroom Seating Plan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Search Bar
              CupertinoSearchTextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                placeholder: 'Search student name',
              ),

              const SizedBox(height: 16),

              // Seat Grid
              Expanded(
                child: GridView.builder(
                  itemCount: filteredSeats.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 4 columns
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


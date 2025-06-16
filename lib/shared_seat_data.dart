class SharedSeatData {
  // Singleton pattern → only 1 copy in app
  static final SharedSeatData _instance = SharedSeatData._internal();

  factory SharedSeatData() {
    return _instance;
  }

  SharedSeatData._internal();

  // Shared Seat List → define your 24 seats here
  List<SeatData> seats = [
    SeatData(studentName: 'Joel', isPresent: true),
    SeatData(studentName: 'Aaron', isPresent: true),
    SeatData(studentName: 'Maryjoyce', isPresent: false),
    SeatData(studentName: 'John', isPresent: true),
    SeatData(studentName: 'Lisa', isPresent: false),
    SeatData(studentName: 'Chris', isPresent: true),
    SeatData(studentName: 'Michael', isPresent: true),
    SeatData(studentName: 'Emma', isPresent: true),
    SeatData(studentName: 'Sophia', isPresent: true),
    SeatData(studentName: 'Oliver', isPresent: true),
    SeatData(studentName: 'James', isPresent: false),
    SeatData(studentName: 'Benjamin', isPresent: true),
    SeatData(studentName: 'Lucas', isPresent: false),
    SeatData(studentName: 'Henry', isPresent: true),
    SeatData(studentName: 'Alexander', isPresent: true),
    SeatData(studentName: 'William', isPresent: false),
    SeatData(studentName: 'Ethan', isPresent: true),
    SeatData(studentName: 'Daniel', isPresent: false),
    SeatData(studentName: 'Matthew', isPresent: true),
    SeatData(studentName: 'David', isPresent: false),
    SeatData(studentName: 'Joseph', isPresent: true),
    SeatData(studentName: 'Samuel', isPresent: true),
    SeatData(studentName: 'Nathan', isPresent: false),
    SeatData(studentName: 'Andrew', isPresent: true),
  ];
}

class SeatData {
  final String studentName;
  bool isPresent;

  SeatData({required this.studentName, required this.isPresent});
}

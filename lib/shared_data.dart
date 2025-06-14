class SharedData {
  static final SharedData _instance = SharedData._internal();

  factory SharedData() {
    return _instance;
  }

  SharedData._internal();

  // Announcements → List of Announcement objects
  List<Announcement> announcements = [
    Announcement(title: 'Exam Week', date: 'July 5, 2025'),
    Announcement(title: 'Project Submission', date: 'July 10, 2025'),
    Announcement(title: 'Holiday - No Classes', date: 'July 15, 2025'),
    Announcement(title: 'School Orientation', date: 'July 20, 2025'),
  ];

  // Grades → subject → grade
  Map<String, int> grades = {
    'Math': 90,
    'English': 85,
    'Science': 88,
    'History': 92,
    'Filipino': 87,
  };
}

// Announcement model
class Announcement {
  final String title;
  final String date;

  Announcement({required this.title, required this.date});
}

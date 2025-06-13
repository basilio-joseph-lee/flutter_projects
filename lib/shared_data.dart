class SharedData {
  // Singleton pattern
  static final SharedData _instance = SharedData._internal();

  factory SharedData() {
    return _instance;
  }

  SharedData._internal();

  // Shared Announcements
  List<String> announcements = [
    'Exam Week - July 5',
    'Project Submission - July 10',
    'Holiday - July 15',
  ];

  // Shared Grades (Student Name → Grade)
  Map<String, int> grades = {
    'John Doe': 90,
    'Jane Smith': 88,
    'Mark Johnson': 85,
  };
}

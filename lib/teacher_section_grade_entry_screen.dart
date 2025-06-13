import 'package:flutter/cupertino.dart';

class TeacherSectionGradeEntryScreen extends StatefulWidget {
  final String sectionName;

  const TeacherSectionGradeEntryScreen({super.key, required this.sectionName});

  @override
  State<TeacherSectionGradeEntryScreen> createState() => _TeacherSectionGradeEntryScreenState();
}

class _TeacherSectionGradeEntryScreenState extends State<TeacherSectionGradeEntryScreen> {
  // Example student list for this section
  List<Map<String, dynamic>> students = [
    {'name': 'John Doe', 'grade': '90'},
    {'name': 'Jane Smith', 'grade': '88'},
    {'name': 'Mark Johnson', 'grade': '85'},
    {'name': 'Lisa Brown', 'grade': '92'},
    {'name': 'Chris Lee', 'grade': '87'},
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.sectionName} - Grades'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.chevron_down),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Table Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Student Name',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Grade',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // Cupertino-safe Divider
            Container(
              height: 1,
              color: CupertinoColors.systemGrey4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            students[index]['name'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CupertinoTextField(
                            controller: TextEditingController(text: students[index]['grade']),
                            onChanged: (value) {
                              students[index]['grade'] = value;
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            textAlign: TextAlign.center,
                            keyboardType: const TextInputType.numberWithOptions(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Save Button
            CupertinoButton.filled(
              child: const Text('Save Grades'),
              onPressed: () {
                // For now → simulate saving (no backend yet)
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Grades Saved'),
                    content: const Text('Grades have been saved (UI only).'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

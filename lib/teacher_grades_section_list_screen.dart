import 'package:flutter/cupertino.dart';
import 'teacher_section_grade_entry_screen.dart';


class TeacherGradesSectionListScreen extends StatelessWidget {
  const TeacherGradesSectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example sections handled by the teacher
    List<String> sections = [
      'Grade 7 - Diamond',
      'Grade 8 - Ruby',
      'Grade 9 - Gold',
      'Grade 10 - Sapphire',
      'Grade 11 - STEM A',
      'Grade 12 - ABM B',
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('My Sections - Grades'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 20),

              const Text(
                'Select a section to view / edit grades:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // Section List Grid
              Expanded(
                child: GridView.builder(
                  itemCount: sections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: sectionCard(sectionName: sections[index]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => TeacherSectionGradeEntryScreen(sectionName: sections[index]),
                          ),
                        );
                      },

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

  // Reusable Section Card
  Widget sectionCard({required String sectionName}) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey4,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(CupertinoIcons.person_3_fill, size: 50, color: CupertinoColors.white),
              const SizedBox(height: 12),
              Text(
                sectionName,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'shared_seat_data.dart';
import 'shared_attendance_data.dart';

class TeacherAttendanceEntryScreen extends StatefulWidget {
  final String sectionName;

  const TeacherAttendanceEntryScreen({super.key, required this.sectionName});

  @override
  State<TeacherAttendanceEntryScreen> createState() => _TeacherAttendanceEntryScreenState();
}

class _TeacherAttendanceEntryScreenState extends State<TeacherAttendanceEntryScreen> {
  DateTime selectedDate = DateTime.now();

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<SeatData> students = List.from(SharedSeatData().seats);

  int get presentCount {
    return students.where((student) => student.isPresent).length;
  }

  int get absentCount {
    return students.where((student) => !student.isPresent).length;
  }

  @override
  void initState() {
    super.initState();
    _loadAttendanceForDate();
  }

  void _loadAttendanceForDate() {
    final sectionRecords = SharedAttendanceData().attendanceRecords[widget.sectionName];
    if (sectionRecords != null && sectionRecords[selectedDate] != null) {
      final studentRecords = sectionRecords[selectedDate]!;
      for (var student in students) {
        student.isPresent = studentRecords[student.studentName] ?? false;
      }
    } else {
      // No attendance yet → default all Present = false
      for (var student in students) {
        student.isPresent = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<SeatData> filteredStudents = students.where((student) {
      return student.studentName.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${widget.sectionName} - Attendance'),
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
            const SizedBox(height: 12),

            // Date button + Mark All buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.calendar, size: 24, color: CupertinoColors.systemBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Date: ${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: selectedDate,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    selectedDate = newDate;
                                    _loadAttendanceForDate();
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: CupertinoColors.activeGreen),
                    onPressed: () {
                      setState(() {
                        for (var student in filteredStudents) {
                          student.isPresent = true;
                        }
                      });
                    },
                  ),

                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Icon(CupertinoIcons.clear_circled_solid, color: CupertinoColors.systemRed),
                    onPressed: () {
                      setState(() {
                        for (var student in filteredStudents) {
                          student.isPresent = false;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Table Header + Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
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
                          'Status',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  CupertinoSearchTextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    placeholder: 'Search student name',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Divider
            Container(
              height: 1,
              color: CupertinoColors.systemGrey4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Attendance Table
            Expanded(
              child: ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            filteredStudents[index].studentName,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                filteredStudents[index].isPresent
                                    ? CupertinoIcons.checkmark_circle_fill
                                    : CupertinoIcons.clear_circled_solid,
                                color: filteredStudents[index].isPresent
                                    ? CupertinoColors.activeGreen
                                    : CupertinoColors.systemRed,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              CupertinoSwitch(
                                value: filteredStudents[index].isPresent,
                                onChanged: (bool value) {
                                  setState(() {
                                    filteredStudents[index].isPresent = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Present / Absent count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Present: $presentCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.activeGreen,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'Absent: $absentCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ],
              ),
            ),

            // Save button
            CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              child: const Text('Save Attendance'),
              onPressed: () {
                final Map<String, bool> studentAttendance = {};
                for (var student in students) {
                  studentAttendance[student.studentName] = student.isPresent;
                }

                SharedAttendanceData().attendanceRecords.putIfAbsent(widget.sectionName, () => {});
                SharedAttendanceData().attendanceRecords[widget.sectionName]![selectedDate] = studentAttendance;

                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Attendance Saved'),
                    content: const Text('Attendance has been saved.'),
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

                print('Attendance for ${widget.sectionName} on $selectedDate: $studentAttendance');
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

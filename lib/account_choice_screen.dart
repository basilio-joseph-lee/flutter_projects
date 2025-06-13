import 'package:flutter/cupertino.dart';
import 'manual_login_screen.dart';
import 'teacher_login_screen.dart';
import 'parent_login_screen.dart';

class AccountChoiceScreen extends StatelessWidget {
  const AccountChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Select Account Type'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 40),

              // Title
              const Text(
                'Choose your role',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // Account Type Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [

                    // Student
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: accountTypeCard(
                        icon: CupertinoIcons.person_fill,
                        label: 'Student',
                        color: CupertinoColors.activeGreen,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const ManualLoginScreen()),
                        );
                      },
                    ),

                    // Parent
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: accountTypeCard(
                        icon: CupertinoIcons.person_2_fill,
                        label: 'Parent',
                        color: CupertinoColors.activeBlue,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const ParentLoginScreen()),
                        );
                      },
                    ),

                    // Teacher
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: accountTypeCard(
                        icon: CupertinoIcons.person_crop_rectangle,
                        label: 'Teacher',
                        color: CupertinoColors.systemOrange,
                      ),
                      onPressed: () {
                        // For now → TODO: Implement TeacherLoginScreen later
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const TeacherLoginScreen()),
                        );

                      },
                    ),

                    // You can add a 4th card here later if needed (ex: Admin, Visitor, etc.)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Account Type Card
  Widget accountTypeCard({required IconData icon, required String label, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: CupertinoColors.white, size: 50),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

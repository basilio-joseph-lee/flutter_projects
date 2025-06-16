import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'teacher_dashboard_screen.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/classroom_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 30,
            left: 20,
            child: CupertinoButton(
              padding: const EdgeInsets.all(4),
              minSize: 0,
              child: const Icon(
                CupertinoIcons.back,
                color: Color(0xFF6B3E26),
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Login Form
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 130),
                padding: const EdgeInsets.all(20),
                width: screenWidth * 0.75,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Welcome, Teacher!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black45,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      CupertinoIcons.person_crop_rectangle,
                      color: Colors.white70,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      controller: usernameController,
                      placeholder: 'Username / Email',
                      icon: CupertinoIcons.mail_solid,
                    ),
                    const SizedBox(height: 14),
                    _buildInputField(
                      controller: passwordController,
                      placeholder: 'Password',
                      icon: CupertinoIcons.lock_fill,
                      obscure: true,
                    ),
                    const SizedBox(height: 20),
                    CupertinoButton(
                      color: Colors.amberAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                      borderRadius: BorderRadius.circular(30),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const TeacherDashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
    bool obscure = false,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      obscureText: obscure,
      padding: const EdgeInsets.all(16),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(icon, color: Color(0xFF2F7E4F)),
      ),
      style: const TextStyle(fontSize: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

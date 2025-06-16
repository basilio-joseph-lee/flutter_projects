import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'manual_login_screen.dart';
import 'parent_login_screen.dart';
import 'teacher_login_screen.dart';

class AccountChoiceScreen extends StatelessWidget {
  const AccountChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/corkboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to SmartLogin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: const [
                          Shadow(offset: Offset(2, 2), blurRadius: 4, color: Colors.black87),
                          Shadow(offset: Offset(-2, -2), blurRadius: 4, color: Colors.black45),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Tap a note to log in as your role',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: const [
                          Shadow(offset: Offset(2, 2), blurRadius: 3, color: Colors.black87),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Transform.translate(
                    offset: const Offset(0, -40), // raised the sticky notes
                    child: Wrap(
                      spacing: 40,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildStickyNote(
                          context,
                          label: "Student",
                          icon: CupertinoIcons.person_crop_circle_fill,
                          baseColor: const Color(0xFFFDF88F),
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) => const ManualLoginScreen()),
                          ),
                        ),
                        _buildStickyNote(
                          context,
                          label: "Parent",
                          icon: CupertinoIcons.person_2_fill,
                          baseColor: const Color(0xFFB3E5FC),
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) => const ParentLoginScreen()),
                          ),
                        ),
                        _buildStickyNote(
                          context,
                          label: "Teacher",
                          icon: CupertinoIcons.book_solid,
                          baseColor: const Color(0xFFFFCCBC),
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (_) => const TeacherLoginScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStickyNote(
      BuildContext context, {
        required String label,
        required IconData icon,
        required Color baseColor,
        required VoidCallback onTap,
      }) {
    final double angle = (Random().nextDouble() * 0.1 - 0.05);
    return _AnimatedStickyNote(
      angle: angle,
      label: label,
      icon: icon,
      baseColor: baseColor,
      onTap: onTap,
    );
  }
}

class _AnimatedStickyNote extends StatefulWidget {
  final double angle;
  final String label;
  final IconData icon;
  final Color baseColor;
  final VoidCallback onTap;

  const _AnimatedStickyNote({
    required this.angle,
    required this.label,
    required this.icon,
    required this.baseColor,
    required this.onTap,
  });

  @override
  State<_AnimatedStickyNote> createState() => _AnimatedStickyNoteState();
}

class _AnimatedStickyNoteState extends State<_AnimatedStickyNote> {
  double _scale = 1.0;

  void _handleTap() async {
    setState(() => _scale = 0.93);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => _scale = 1.0);
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.angle,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 100),
          scale: _scale,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 190,
                height: 260,
                padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.baseColor.withOpacity(0.98),
                      widget.baseColor.withOpacity(0.88),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(3, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(widget.icon, size: 60, color: Colors.black87),
                    const SizedBox(height: 14),
                    Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -18,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.redAccent, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

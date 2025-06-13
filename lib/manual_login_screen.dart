import 'package:flutter/cupertino.dart';
import 'kiosk_main_menu.dart';

class ManualLoginScreen extends StatefulWidget {
  const ManualLoginScreen({super.key});

  @override
  State<ManualLoginScreen> createState() => _ManualLoginScreenState();
}

class _ManualLoginScreenState extends State<ManualLoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Manual Login'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                controller: usernameController,
                placeholder: 'Username / Student ID',
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: passwordController,
                placeholder: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              CupertinoButton.filled(
                child: const Text('Login'),
                onPressed: () {
                  // Simulate successful login → navigate to KioskMainMenu
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => KioskMainMenu(studentName: usernameController.text),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

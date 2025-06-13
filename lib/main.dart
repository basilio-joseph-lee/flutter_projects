import 'package:flutter/cupertino.dart';
import 'kiosk_main_menu.dart';
import 'manual_login_screen.dart';
import 'account_choice_screen.dart';

void main() {
  runApp(
    CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: const AccountChoiceScreen(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Interactive Classroom Kiosk'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Example logo (replace with your logo if needed)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(CupertinoIcons.person_3_fill, size: 80, color: CupertinoColors.activeBlue),
              ),

              const SizedBox(height: 20),

              // RFID Login button
              CupertinoButton.filled(
                child: const Text("Tap RFID Card"),
                onPressed: () {
                  // TODO: Trigger RFID reader logic here
                },
              ),

              const SizedBox(height: 20),

              // Facial Recognition button
              CupertinoButton.filled(
                child: const Text("Facial Recognition"),
                onPressed: () {
                  // TODO: Trigger Facial Recognition logic here
                },
              ),

              const SizedBox(height: 20),

              // Manual Login button
              CupertinoButton.filled(
                child: const Text("Manual Login"),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const ManualLoginScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

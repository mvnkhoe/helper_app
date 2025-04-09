import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tips & Advice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Tips:\n- Stay organized\n- Write a good motivation letter\n- Practice for interviews',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 600
                  ? 18
                  : 14), // Adjust text size
        ),
      ),
    );
  }
}

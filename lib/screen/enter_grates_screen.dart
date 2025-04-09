import 'package:flutter/material.dart';

class EnterGradesScreen extends StatelessWidget {
  const EnterGradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Grades')),
      body: const Center(child: Text('Form to input grades.')),
    );
  }
}

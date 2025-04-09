import 'package:flutter/material.dart';

class ApplicationGuideScreen extends StatelessWidget {
  const ApplicationGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application Guide')),
      body: const Center(
          child: Text('Steps and requirements for university applications.')),
    );
  }
}

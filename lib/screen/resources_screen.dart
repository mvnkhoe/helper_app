import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: ListView(
        children: const [
          ListTile(title: Text('Download NUL Application Form')),
          ListTile(title: Text('University Brochures')),
          ListTile(title: Text('How to Write a Motivation Letter')),
        ],
      ),
    );
  }
}

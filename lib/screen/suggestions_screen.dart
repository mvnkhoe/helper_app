import 'package:flutter/material.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suggestions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Suggestions based on grades:\n- BSc Computer Science\n- Diploma in Engineering\n- BA in Education',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 600
                  ? 18
                  : 14), // Adjust text size
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChatAssistantScreen extends StatelessWidget {
  const ChatAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ask Assistant')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text('How can I assist you today?'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Type your question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: null, child: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

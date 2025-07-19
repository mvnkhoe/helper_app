import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatAssistantScreen extends StatefulWidget {
  const ChatAssistantScreen({super.key});

  @override
  State<ChatAssistantScreen> createState() => _ChatAssistantScreenState();
}

class _ChatAssistantScreenState extends State<ChatAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': input});
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.134.101:8000/chat'), // Change this to your real endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': input}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final reply = responseData['response'];

        setState(() {
          _messages.add({'sender': 'bot', 'text': reply});
        });
      } else {
        setState(() {
          _messages.add({
            'sender': 'bot',
            'text':
                '⚠️ Could not fetch response (Status: ${response.statusCode})'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'text':
              '❌ Error: Failed to connect to server.\nDetails: ${e.toString()}'
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildMessage(String sender, String text) {
    bool isUser = sender == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildChatBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _isLoading ? _messages.length + 1 : _messages.length,
      itemBuilder: (context, index) {
        if (_isLoading && index == _messages.length) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                'Assistant is typing...',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        } else {
          final message = _messages[index];
          return _buildMessage(message['sender']!, message['text']!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Ask Assistant', style: GoogleFonts.poppins()),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: _messages.isEmpty
                  ? Center(
                      child: Text(
                        'How can I assist you today?',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    )
                  : _buildChatBody(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      border: const OutlineInputBorder(),
                      hintStyle: GoogleFonts.poppins(),
                    ),
                    style: GoogleFonts.poppins(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

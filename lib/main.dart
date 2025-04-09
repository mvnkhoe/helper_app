import 'package:flutter/material.dart';
import 'package:helper_app/screen/signin.dart';

import 'screen/application_guide_screen.dart';
import 'screen/chat_assistant_screen.dart';
import 'screen/enter_grates_screen.dart';
import 'screen/home/home_screen.dart';
import 'screen/resources_screen.dart';
import 'screen/suggestions_screen.dart';
import 'screen/tips_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Helper App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/application-guide': (context) => const ApplicationGuideScreen(),
        '/enter-grades': (context) => const EnterGradesScreen(),
        '/suggestions': (context) => const SuggestionsScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/tips': (context) => const TipsScreen(),
        '/chat-assistant': (context) => const ChatAssistantScreen(),
        '/signin': (context) => Signin(),
      },
    );
  }
}

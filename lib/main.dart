import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:helper_app/providers/app_auth.dart';
import 'package:helper_app/screen/sign_up_screen.dart';
import 'package:helper_app/screen/signin.dart';
import 'package:provider/provider.dart';
import 'screen/application_guide_screen.dart';
import 'screen/chat_assistant_screen.dart';
import 'screen/enter_grates_screen.dart';
import 'screen/home/home_screen.dart';
import 'screen/resources_screen.dart';
import 'screen/suggestions_screen.dart';
import 'screen/tips_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => AppAuthProvider())],
    child: const MyApp(),
  ));
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
        '/': (context) => SignInPage(),
        '/signin': (context) => SignInPage(),
        '/home': (context) => const HomeScreen(),
        '/application-guide': (context) => const ApplicationGuideScreen(),
        '/enter-grades': (context) => EnterGradesScreen(),
        '/suggestions': (context) => const SuggestionsScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/tips': (context) => const TipsScreen(),
        '/signup': (context) => const SignUpPage(),
        '/chat-assistant': (context) => const ChatAssistantScreen(),
      },
    );
  }
}

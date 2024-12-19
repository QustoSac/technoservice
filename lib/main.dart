import 'package:flutter/material.dart';
import 'screens/request_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Technoservice',
      theme: ThemeData(
        fontFamily: 'Monotype Corsiva',
        scaffoldBackgroundColor: const Color(0xFFD2F1F0),
        primaryColor: const Color(0xFF5EC6CD),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: RequestListScreen(),
    );
  }
}

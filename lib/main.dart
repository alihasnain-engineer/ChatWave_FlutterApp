import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const ChatWaveApp());
}

class ChatWaveApp extends StatelessWidget {
  const ChatWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatWave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const SplashScreen(),
    );
  }
}

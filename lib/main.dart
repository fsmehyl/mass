import 'package:flutter/material.dart';
import 'package:mass/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M.A.S.S.',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'M.A.S.S.'),
      debugShowCheckedModeBanner: false,
    );
  }
}

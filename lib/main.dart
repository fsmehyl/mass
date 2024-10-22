import 'package:flutter/material.dart';
import 'home_page.dart';

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
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          datePickerTheme: DatePickerThemeData(
            dividerColor: Colors.blue,
          )).copyWith(
          colorScheme: ColorScheme.light(
        primary: Colors.blue,
      )),
      home: const MyHomePage(title: 'M.A.S.S.'),
      debugShowCheckedModeBanner: false,
    );
  }
}

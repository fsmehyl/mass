import 'package:flutter/material.dart';

class RapidTestInfoPage extends StatelessWidget {
  const RapidTestInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 137, 166),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 124, 213, 233),
        title: const Text(
          'Informácie o Rapid teste',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rapid TEST',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Maecenas lobortis imperdiet justo vitae blandit. Nullam eget elit risus. Quisque nulla neque, scelerisque malesuada auctor ac, tempus vel leo. Nullam consectetur dui at ligula cursus, id molestie metus varius.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Ako sa otestovať?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- Ut vel erat efficitur, fringilla ante non, pellentesque ipsum.\n'
                '- Ut id laoreet ex, eu laoreet lacus.\n'
                '- Donec suscipit semper venenatis. Donec venenatis.\n'
                '- Mauris ullamcorper ut orci eget molestie. Nullam non porta odio. Cras gravida consectetur dui vel dictum.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis sed laoreet ex. Maecenas nec elit feugiat, viverra neque sit amet, rhoncus mi.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

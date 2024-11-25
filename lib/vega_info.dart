import 'package:flutter/material.dart';

class VegaTestInfoPage extends StatelessWidget {
  const VegaTestInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 137, 166),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 124, 213, 233),
        title: const Text(
          'Informácie o Vega teste',
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
                'Vega TEST',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed posuere vehicula ipsum eget euismod. Donec a dictum dui. Praesent ac magna nibh. Aenean vel arcu sodales, euismod dolor eget, lobortis lacus. Nulla quam elit, vestibulum id leo at, hendrerit aliquam ex. Nam massa ex, dignissim at sodales vitae, laoreet vel enim. Morbi efficitur pulvinar risus, eget aliquam massa. Integer bibendum, nibh sit amet convallis luctus, mauris metus convallis felis, id interdum odio velit eget risus. Quisque sed volutpat ante. Cras sed efficitur augue. Praesent rutrum pellentesque pharetra. Duis viverra sapien quis nulla interdum, eu consequat libero imperdiet.',
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
                '- Quisque quis mi id tellus egestas sagittis a et nisi.\n'
                '- Quisque a convallis dolor. Proin id dolor quam. Proin sit amet imperdiet risus.\n'
                '- In blandit luctus justo, et pulvinar purus fermentum at.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Pellentesque tempus, elit non lobortis congue, orci urna iaculis turpis.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

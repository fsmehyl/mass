// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'fill_form_one.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _fileNames = [];

  @override
  void initState() {
    super.initState();
    _loadFileNames();
  }

  void _loadFileNames() {
    List<String> formNames = [
      'Deti vychovávané v detskom domove',
      'Násilie páchané na deťoch v domácnostiach',
      'Rôzne prípady detí DO 10 rokov',
      'Rôzne prípady detí DO 5 rokov',
      'viac formulárov čoskoro...',
    ];

    setState(() {
      _fileNames = formNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 136, 255),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Xml M.A.S.S. formuláre k dispozícií:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              for (var fileName in _fileNames)
                Column(
                  children: [
                    SizedBox(
                      width: 800,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          switch (fileName) {
                            case 'Deti vychovávané v detskom domove':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FillFormOne(),
                                ),
                              );
                              break;
                            case 'Násilie páchané na deťoch v domácnostiach':
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FillFormTwo(),
                                ),
                              );*/
                              break;
                            case 'Rôzne prípady detí DO 5 rokov':
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FillFormThree(),
                                ),
                              );*/
                              break;
                            default:

                              // ignore: avoid_print
                              print('Formulár nie je pripravený');
                          }
                        },
                        icon: const Icon(Icons.file_open_outlined),
                        label: Column(
                          children: [
                            Text(
                              fileName,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Kliknite pre pokračovanie...',
                              style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 0, 136, 255), width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Flutter_logo.png',
                      width: 350,
                      height: 350,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Poháňané nástrojom Flutter',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

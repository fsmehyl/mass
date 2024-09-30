// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'fill_form_one.dart';
import 'fill_form_two.dart';
import 'fill_form_three.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> loadFiles = [
    'Deti vychovávané v detskom domove',
    'Násilie páchané na deťoch v domácnostiach',
    'Rôzne prípady detí DO 10 rokov',
    'Rôzne prípady detí DO 5 rokov',
    'Deti, ktoré pricestovali zo zahraničia',
    'viac formulárov čoskoro...',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 200, 243),
          title: Text(
            widget.title,
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Vyberte formulár na vyplnenie:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                for (var fileNames in loadFiles)
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 500,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              switch (fileNames) {
                                case 'Deti vychovávané v detskom domove':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FillFormOne(),
                                    ),
                                  );
                                  break;
                                case 'Násilie páchané na deťoch v domácnostiach':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FillFormTwo(),
                                    ),
                                  );
                                  break;
                                case 'Rôzne prípady detí DO 10 rokov':
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FillFormThree(),
                                    ),
                                  );
                                  break;
                                default:
                                  showDialog(context: context,
                                   builder: (context) => AlertDialog(
                                    title: Text('Upozornenie'),
                                    content: Text('Tento formulár zatiaľ ešte nie je dorobený, o jeho vytvorení vás budeme kontaktovať mailom, prosím zatiaľ používajte iné formuláre, ďakujeme'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                   ),
                                  );
                              }
                            },
                            icon: Icon(Icons.file_open_outlined),
                            label: Column(
                              children: [
                                Text(
                                  fileNames,
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: Color.fromARGB(255, 7, 200, 243),
                      )),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/Flutter_logo.png',
                        width: 350,
                        height: 350,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Poháňané nástrojom Flutter',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
    );
  }
}

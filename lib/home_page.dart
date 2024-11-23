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
      backgroundColor: const Color.fromARGB(255, 4, 137, 166),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 155, 219, 233),
        title: Text(
          widget.title,
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 4, 137, 166),
                    title: const Text('Informácie o aplikácií MASS',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold)),
                    content: const Text(
                      'Multiplatformová aplikácia MASS alebo aj Multiplatformová aplikácia pre sociálne služby je môj návrh aplikácie vo vývojovom prostredí Flutter, ktorá je vytvorená za účelom bakalárskej práce a pomoci pri rýchlom diagnostickom testovaní pre sociálnych pracovníkov. Aplikácia obsahuje niekoľko typov rôznych XML formulárov, ktoré sú parsované aplikáciou a následne zobrazené na vyklikávanie odpovedí na rôznorodé otázky, po ich vyplnení sa používateľovi zobrazí graf predstavujúci mieru ohrozenia dieťaťa v jednotlivých kategóriach.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30),
                child: const Center(
                  child: Text(
                    'VYBERTE PROSÍM FORMULÁR',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      loadFiles[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FillFormOne(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FillFormTwo(),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FillFormThree(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.white,
                              content: Text('Momentálne nedostupný...',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 4, 137, 166),
                                      fontWeight: FontWeight.bold))),
                        );
                      }
                    },
                  );
                },
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
                itemCount: loadFiles.length,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: const Color.fromARGB(255, 155, 219, 233),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Flutter_logo.png',
                      width: 350,
                      height: 350,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Poháňané nástrojom Flutter',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

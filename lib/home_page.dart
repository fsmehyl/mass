import 'package:flutter/material.dart';
import 'fill_form_one.dart';
import 'fill_form_two.dart';
import 'fill_form_three.dart';
import 'rapid_info.dart';
import 'vega_info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> loadFiles = [
    'Pre deti od 2 do 6 rokov',
    'Pre deti od 6,1 do 12 rokov',
    'Pre deti od 12 rokov',
    'viac formulárov čoskoro...',
  ];

  int tappedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 137, 166),
      appBar: AppBar(
        leading: PopupMenuButton(
          icon: const Icon(Icons.menu),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Informácie o RAPID_TEST_CAN'),
              onTap: () {
                Future.delayed(
                  Duration.zero,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RapidTestInfoPage(),
                    ),
                  ),
                );
              },
            ),
            PopupMenuItem(
              child: const Text('Informácie o VEGA_TEST'),
              onTap: () {
                Future.delayed(
                  Duration.zero,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VegaTestInfoPage(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 124, 213, 233),
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
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
                    'RAPID_TEST_CAN',
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 124, 213, 233),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 123, 123, 123),
        currentIndex: tappedValue,
        onTap: (value) {
          setState(() {
            tappedValue = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'RAPID_TEST_CAN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'VEGA_TEST',
          ),
        ],
      ),
    );
  }
}

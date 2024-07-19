import 'package:flutter/material.dart';

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
    List<String> filePaths = [
      'assets/xml_forms/form_one.xml',
      'assets/xml_forms/form_two.xml',
      'assets/xml_forms/form_three.xml',
      'assets/xml_forms/more_forms_soon',
      'assets/xml_forms/more_forms_soon',
      'assets/xml_forms/more_forms_soon',
      'assets/xml_forms/more_forms_soon',
      'assets/xml_forms/more_forms_soon',
      'assets/xml_forms/more_forms_soon',
    
    ];

    setState(() {
      _fileNames = filePaths.map((path) {
        String fileName = path.split('/').last;
        return fileName.replaceAll('.xml', ' ');
      }).toList();
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
                'Xml forms for M.A.S.S. available:',
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
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add your action here
                        switch (fileName) {
                          case 'form_one ':
                            print("1");
                            break;
                          case 'form_two ':
                            print("2");
                            break;
                          case 'form_three ':
                            print("3");
                            break;
                          default:
                            print('Error');
                        }
                      },
                      icon: Icon(Icons.file_open_outlined),
                      label: Column(
                        children: [
                          Text(
                            fileName,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Click me to continue...',
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              const SizedBox(height: 20), // Add spacing before the image
              Container(
                margin: EdgeInsets.all(30), // Add margin here
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 0, 136, 255), width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Flutter_logo.png',
                      width: 350, // Adjust the width as needed
                      height: 350, // Adjust the height as needed
                    ),
                    const SizedBox(height: 10), // Add spacing between image and text
                    Text(
                      'Powered by Flutter',
                      style: const TextStyle(
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

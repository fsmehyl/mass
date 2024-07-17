import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart';

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
    // List of files manually specified (since we cannot list files directly in assets)
    List<String> filePaths = [
      'assets/xml_forms/form_one.xml',
      'assets/xml_forms/form_two.xml',
      'assets/xml_forms/form_three.xml',
    ];

    // Extract the file names from the paths and remove the .xml extension
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
        backgroundColor: Color.fromARGB(255, 0, 136, 255),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to M.A.S.S.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'XML Files:',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            for (var fileName in _fileNames)
              Text(
                fileName,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

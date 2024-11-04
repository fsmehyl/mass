import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mass/graph.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'home_page.dart';

class FormBuilderPackage extends StatefulWidget {
  final String xmlFilePath;
  final String formTitle;

  const FormBuilderPackage({
    super.key,
    required this.xmlFilePath,
    required this.formTitle,
  });

  @override
  State<FormBuilderPackage> createState() => _FormBuilderPackageState();
}

class _FormBuilderPackageState extends State<FormBuilderPackage> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<Map<String, dynamic>> questions = [];
  Map<String, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final data = await rootBundle.loadString(widget.xmlFilePath);
    final document = xml.XmlDocument.parse(data);
    final form = document.findAllElements('form').first;

    List<Map<String, dynamic>> loadedQuestions = [];

    form.findAllElements('question').forEach((questionNode) {
      final id = questionNode.findElements('id').first.text;
      final text = questionNode.findElements('text').first.text;
      final type = questionNode.findElements('type').first.text;
      List<String> options = [];

      if (type == 'radio' || type == 'checkbox' || type == 'select') {
        options = questionNode
            .findElements('options')
            .first
            .findElements('option')
            .map((optionNode) => optionNode.text)
            .toList();
      }

      loadedQuestions.add({
        'id': id,
        'text': text,
        'type': type,
        'options': options,
      });
    });

    setState(() {
      questions = loadedQuestions;
    });
  }

  List<Widget> _buildFormFields() {
    return questions.map((question) {
      switch (question['type']) {
        case 'text':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FormBuilderTextField(
              cursorColor: const Color.fromARGB(255, 18, 125, 240),
              name: question['id'],
              decoration: InputDecoration(
                  labelText: question['text'],
                  hoverColor: const Color.fromARGB(255, 18, 125, 240),
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  iconColor: Colors.blue),
            ),
          );
        case 'radio':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FormBuilderChoiceChip<String>(
              name: question['id'],
              decoration: InputDecoration(labelText: question['text']),
              options: question['options']
                  .map<FormBuilderChipOption<String>>(
                    (String option) => FormBuilderChipOption(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              selectedColor: const Color.fromARGB(255, 18, 125, 240),
            ),
          );
        case 'checkbox':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FormBuilderFilterChip(
              name: question['id'],
              decoration: InputDecoration(labelText: question['text']),
              options: question['options']
                  .map<FormBuilderChipOption<String>>(
                    (String option) => FormBuilderChipOption(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              selectedColor: const Color.fromARGB(255, 18, 125, 240),
              checkmarkColor: const Color.fromARGB(255, 0, 0, 0),
            ),
          );
        case 'select':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FormBuilderDropdown<String>(
              name: question['id'],
              decoration: InputDecoration(
                labelText: question['text'],
                border: const OutlineInputBorder(),
              ),
              items: question['options']
                  .map<DropdownMenuItem<String>>((String option) =>
                      DropdownMenuItem<String>(
                          value: option, child: Text(option)))
                  .toList(),
            ),
          );
        case 'slider':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FormBuilderSlider(
              name: question['id'],
              decoration: InputDecoration(
                labelText: question['text'],
                labelStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              min: 1.0,
              max: 5.0,
              initialValue: 3.0,
              divisions: 4,
              activeColor: const Color.fromARGB(255, 18, 125, 240),
              inactiveColor: const Color.fromARGB(255, 192, 192, 192),
            ),
          );
        case 'date':
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FormBuilderDateTimePicker(
              name: question['id'],
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: question['text'],
                border: const OutlineInputBorder(),
              ),
            ),
          );
        default:
          return const SizedBox
              .shrink(); // Return an empty widget for unsupported types
      }
    }).toList();
  }

  Future<void> _saveForm() async {
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('form', nest: () {
      for (var question in questions) {
        builder.element('question', nest: () {
          builder.element('id', nest: question['id']);
          builder.element('answer', nest: answers[question['id']] ?? '');
        });
      }
    });

    final document = builder.buildDocument();

    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else if (Platform.isIOS || Platform.isMacOS) {
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isWindows || Platform.isLinux) {
      directory = await getApplicationSupportDirectory();
    } else {
      directory = null;
    }

    if (directory != null) {
      final filePath = '${directory.path}/form_data.xml';
      final file = File(filePath);

      // Zápis súboru
      await file.writeAsString(document.toXmlString(pretty: true));

      debugPrint('Súbor uložený na: $filePath');

      // Načítanie a zobrazenie obsahu súboru
      final savedData = await file.readAsString();
      _showFileContent(savedData);
    } else {
      debugPrint('Nepodarilo sa získať adresár pre uloženie súboru.');
    }
  }

  void _showFileContent(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Obsah súboru'),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'M.A.S.S.'),
                  ),
                  (route) => false, // Odstráni všetky predchádzajúce stránky
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.formTitle,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold)),
      ),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      ..._buildFormFields(),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     HorizontalBarChartWithLevels()),
                          );
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color.fromARGB(255, 18, 125, 240),
                        ),
                        label: const Column(
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'Kliknite pre zber dát...',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 18, 125, 240)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

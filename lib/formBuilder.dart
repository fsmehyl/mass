import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;
import 'home_page.dart';

class FormBuilder extends StatefulWidget {
  final String xmlFilePath;
  final String formTitle;

  const FormBuilder({required this.xmlFilePath, required this.formTitle});

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
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

      questions.add({
        'id': id,
        'text': text,
        'type': type,
        'options': options,
      });
    });

    setState(() {});
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

      print('Súbor uložený na: $filePath');

      // Načítanie a zobrazenie obsahu súboru
      final savedData = await file.readAsString();
      _showFileContent(savedData);
    } else {
      print('Nepodarilo sa získať adresár pre uloženie súboru.');
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
                    builder: (context) => MyHomePage(title: 'M.A.S.S.'),
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
        title: Text(widget.formTitle,
            style: const TextStyle(color: Colors.purple)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: questions.map((question) {
                  switch (question['type']) {
                    case 'text':
                      return _buildTextField(question);
                    case 'date':
                      return _buildDateField(question);
                    case 'radio':
                      return _buildRadioField(question);
                    case 'checkbox':
                      return _buildCheckboxField(question);
                    case 'select':
                      return _buildSelectField(question);
                    case 'number':
                      return _buildNumberField(question);
                    case 'textarea':
                      return _buildTextareaField(question);
                    default:
                      return const SizedBox.shrink();
                  }
                }).toList(),
              ),
              Column(
                children: [
                  SizedBox(
                    child: ElevatedButton.icon(
                      onPressed: _saveForm, // Save form data to XML
                      icon: const Icon(Icons.send),
                      label: Column(
                        children: const [
                          SizedBox(height: 5),
                          Text(
                            'Kliknite pre zber dát...',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question['text'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          onChanged: (value) {
            answers[question['id']] = value;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateField(Map<String, dynamic> question) {
    return _buildTextField(question);
  }

  Widget _buildRadioField(Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question['text'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Column(
          children: question['options'].map<Widget>((option) {
            return Row(
              children: [
                Radio(
                    value: option,
                    groupValue: answers[question['id']],
                    onChanged: (value) {
                      setState(() {
                        answers[question['id']] = value;
                      });
                    }),
                Text(option),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCheckboxField(Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question['text'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(
          children: question['options'].map<Widget>((option) {
            return Row(
              children: [
                Checkbox(
                  value: answers[question['id']]?.contains(option) ?? false,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        answers[question['id']] =
                            (answers[question['id']] ?? [])..add(option);
                      } else {
                        answers[question['id']]?.remove(option);
                      }
                    });
                  },
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSelectField(Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question['text'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          items:
              question['options'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              answers[question['id']] = newValue;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNumberField(Map<String, dynamic> question) {
    return _buildTextField(question);
  }

  Widget _buildTextareaField(Map<String, dynamic> question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question['text'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          maxLines: 4,
          onChanged: (value) {
            answers[question['id']] = value;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

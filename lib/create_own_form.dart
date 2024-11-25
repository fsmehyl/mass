import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;

class CreateFormPage extends StatefulWidget {
  @override
  _CreateFormPageState createState() => _CreateFormPageState();
}

class _CreateFormPageState extends State<CreateFormPage> {
  List<Map<String, dynamic>> customQuestions = [];

  void _addQuestion(Map<String, dynamic> question) {
    setState(() {
      customQuestions.add(question);
    });
  }

  Future<void> _saveFormAsXml() async {
    
    final builder = xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('form', nest: () {
      for (var question in customQuestions) {
        builder.element('question', nest: () {
          builder.element('text', nest: question['text']);
          builder.element('type', nest: question['type']);
          if (question['options'] != null) {
            builder.element('options', nest: () {
              for (var option in question['options']) {
                builder.element('option', nest: option['text']);
              }
            });
          }
        });
      }
    });
    final xmlDocument = builder.buildDocument();
    final xmlString = xmlDocument.toXmlString(pretty: true);

    
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/custom_form.xml';
      final file = File(filePath);
      await file.writeAsString(xmlString);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulár uložený: $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chyba pri ukladaní: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vytvoriť formulár')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: customQuestions.length,
              itemBuilder: (context, index) {
                final question = customQuestions[index];
                return ListTile(
                  title: Text(question['text']),
                  subtitle: Text('Typ: ${question['type']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        customQuestions.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddQuestionPage(onSubmit: _addQuestion),
                ),
              );
            },
            child: const Text('Pridať otázku'),
          ),
          if (customQuestions.isNotEmpty)
            ElevatedButton(
              onPressed: () async {
                await _saveFormAsXml();
              },
              child: const Text('Uložiť formulár'),
            ),
        ],
      ),
    );
  }
}

class AddQuestionPage extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSubmit;

  const AddQuestionPage({required this.onSubmit});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  String _selectedType = 'text';
  List<Map<String, String>> _options = [];

  void _addOption(String text) {
    setState(() {
      _options.add({'text': text});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pridať otázku')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Otázka'),
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : 'Zadajte otázku',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: [
                  const DropdownMenuItem(value: 'text', child: Text('Text')),
                  const DropdownMenuItem(value: 'date', child: Text('Dátum')),
                  const DropdownMenuItem(value: 'radio', child: Text('Radio')),
                  const DropdownMenuItem(
                      value: 'select', child: Text('Select')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                    _options.clear();
                  });
                },
                decoration: const InputDecoration(labelText: 'Typ otázky'),
              ),
              if (_selectedType == 'radio' || _selectedType == 'select')
                Column(
                  children: [
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showAddOptionDialog(context);
                      },
                      child: const Text('Pridať možnosť'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _options.length,
                      itemBuilder: (context, index) {
                        final option = _options[index];
                        return ListTile(
                          title: Text(option['text'] ?? ''),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _options.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit({
                      'text': _questionController.text,
                      'type': _selectedType,
                      'options': _options,
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Uložiť otázku'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddOptionDialog(BuildContext context) {
    final TextEditingController optionController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Pridať možnosť'),
          content: TextFormField(
            controller: optionController,
            decoration: const InputDecoration(labelText: 'Text možnosti'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Zrušiť'),
            ),
            TextButton(
              onPressed: () {
                _addOption(optionController.text);
                Navigator.of(ctx).pop();
              },
              child: const Text('Pridať'),
            ),
          ],
        );
      },
    );
  }
}

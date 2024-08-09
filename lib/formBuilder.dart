// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;

class FormBuilder extends StatefulWidget {
  final String xmlFilePath;
  final String formTitle;

  const FormBuilder({required this.xmlFilePath, required this.formTitle});

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  List<Map<String, dynamic>> questions = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formTitle, style: const TextStyle(color: Colors.purple)),
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
                      onPressed: () {
                        // Add form submission or data collection logic here
                      },
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
                Radio(value: option, groupValue: null, onChanged: (value) {}),
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
        Text(question['text'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Column(
          children: question['options'].map<Widget>((option) {
            return Row(
              children: [
                Checkbox(value: false, onChanged: (bool? value) {}),
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
          onChanged: (String? newValue) {},
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
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

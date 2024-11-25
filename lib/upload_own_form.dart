import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:xml/xml.dart' as xml;

class UploadAndGenerateFormPage extends StatefulWidget {
  @override
  _UploadAndGenerateFormPageState createState() =>
      _UploadAndGenerateFormPageState();
}

class _UploadAndGenerateFormPageState extends State<UploadAndGenerateFormPage> {
  List<Map<String, dynamic>> questions = [];

  Future<void> _pickXmlFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xml'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();
        _parseXml(content);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chyba pri nahrávaní súboru: $e')),
      );
    }
  }

  void _parseXml(String xmlContent) {
    try {
      final document = xml.XmlDocument.parse(xmlContent);
      final questionElements = document.findAllElements('question');
      final List<Map<String, dynamic>> parsedQuestions = [];

      for (final question in questionElements) {
        final text = question.findElements('text').first.text;
        final type = question.findElements('type').first.text;
        final options = question
            .findElements('options')
            .expand((e) => e.findElements('option'))
            .map((e) => {'text': e.text})
            .toList();

        parsedQuestions.add({
          'text': text,
          'type': type,
          'options': options.isEmpty ? null : options,
        });
      }

      setState(() {
        questions = parsedQuestions;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chyba pri spracovaní XML: $e')),
      );
    }
  }

  Widget _buildDynamicForm() {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final type = question['type'];
        final text = question['text'];

        if (type == 'text') {
          return TextFormField(
            decoration: InputDecoration(labelText: text),
          );
        } else if (type == 'date') {
          return TextFormField(
            decoration: InputDecoration(labelText: text),
            readOnly: true,
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
            },
          );
        } else if (type == 'radio' && question['options'] != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option['text']),
                  value: option['text'],
                  groupValue: null,
                  onChanged: (value) {},
                );
              }).toList(),
            ],
          );
        } else if (type == 'select' && question['options'] != null) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: text),
            items: question['options'].map<DropdownMenuItem<String>>((option) {
              return DropdownMenuItem<String>(
                value: option['text'],
                child: Text(option['text']),
              );
            }).toList(),
            onChanged: (value) {},
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vlož XML formulár')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickXmlFile,
            child: const Text('Nahrať XML súbor'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: questions.isEmpty
                ? const Center(
                    child: Text('Nahrajte XML na zobrazenie formulára.'))
                : _buildDynamicForm(),
          ),
        ],
      ),
    );
  }
}

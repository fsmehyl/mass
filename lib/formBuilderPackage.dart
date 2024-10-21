import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mass/formBuilder.dart' as custom_form_builder;
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;
import 'home_page.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
          return FormBuilderTextField(
            name: question['id'],
            decoration: InputDecoration(labelText: question['text']),
          );
        case 'radio':
          return FormBuilderSwitch(
            name: question['id'],
            title: Text(question['text']),
            activeColor: Color.fromARGB(255, 18, 125, 240),
            initialValue: false,
          );
        case 'checkbox':
          return FormBuilderCheckboxGroup(
            name: question['id'],
            decoration: InputDecoration(labelText: question['text']),
            checkColor: Color.fromARGB(255, 255, 255, 255),
            activeColor: Color.fromARGB(255, 18, 125, 240),
            options: question['options']
                .map<FormBuilderFieldOption<String>>(
                    (String option) => FormBuilderFieldOption(value: option))
                .toList(),
          );
        case 'select':
          return FormBuilderDropdown<String>(
            name: question['id'],
            decoration: InputDecoration(
              labelText: question['text'],
            ),
            dropdownColor: Color.fromARGB(255, 230, 230, 230),
            focusColor: Color.fromARGB(60, 18, 125, 240),
            iconEnabledColor: Color.fromARGB(255, 18, 125, 240),
            iconDisabledColor: Color.fromARGB(255, 18, 125, 240),
            items: question['options']
                .map<DropdownMenuItem<String>>((String option) =>
                    DropdownMenuItem<String>(
                        value: option, child: Text(option)))
                .toList(),
          );
        case 'slider':
          return FormBuilderSlider(
            name: question['id'],
            decoration: InputDecoration(labelText: question['slider']),
            min: 1.0,
            max: 5.0,
            initialValue: 3.0,
            divisions: 4,
            activeColor: Color.fromARGB(255, 18, 125, 240),
            inactiveColor: Color.fromARGB(255, 192, 192, 192),
          );
          case 'date':
          return FormBuilderDateTimePicker(
            name: question['id'],
            inputType: InputType.date,
            decoration: InputDecoration(labelText: question['text']),
          );
        default:
          return SizedBox
              .shrink(); // Return an empty widget for unsupported types
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formTitle),
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      ..._buildFormFields(),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                            // Handle form submission logic here
                            print(_formKey.currentState?.value);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
          ),
    );
  }
}



// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'formBuilderPackage.dart';

class FillFormOne extends StatefulWidget {
  const FillFormOne({super.key});

  @override
  State<FillFormOne> createState() => _FillFormOneState();
}



class _FillFormOneState extends State<FillFormOne> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderPackage(
      xmlFilePath: 'assets/xml_forms/form_one.xml', // Uveďte cestu k vášmu XML súboru
      formTitle: 'DVVDD', // Nastavte názov formulára
    );
  }
}



import 'package:flutter/material.dart';
import 'formBuilder.dart';

class FillFormOne extends StatefulWidget {
  const FillFormOne({super.key});

  @override
  State<FillFormOne> createState() => _FillFormOneState();
}



class _FillFormOneState extends State<FillFormOne> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      xmlFilePath: 'assets/xml_forms/form_one.xml', // Uveďte cestu k vášmu XML súboru
      formTitle: 'DVVDD', // Nastavte názov formulára
    );
  }
}



import 'package:flutter/material.dart';
import 'formBuilder.dart';

class FillFormTwo extends StatefulWidget {
  const FillFormTwo({super.key});

  @override
  State<FillFormTwo> createState() => _FillFormTwoState();
}



class _FillFormTwoState extends State<FillFormTwo> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      xmlFilePath: 'assets/xml_forms/form_two.xml', // Uveďte cestu k vášmu XML súboru
      formTitle: 'NPNDVD', // Nastavte názov formulára
    );
  }
}

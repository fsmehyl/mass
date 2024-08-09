

import 'package:flutter/material.dart';
import 'formBuilder.dart';

class FillFormThree extends StatefulWidget {
  const FillFormThree({super.key});

  @override
  State<FillFormThree> createState() => _FillFormThreeState();
}



class _FillFormThreeState extends State<FillFormThree> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      xmlFilePath: 'assets/xml_forms/form_three.xml', // Uveďte cestu k vášmu XML súboru
      formTitle: 'RPDD10R', // Nastavte názov formulára
    );
  }
}
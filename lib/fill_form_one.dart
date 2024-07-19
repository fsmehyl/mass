import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;

class FillFormOne extends StatefulWidget {
  @override
  _FillFormOneState createState() => _FillFormOneState();
}

class _FillFormOneState extends State<FillFormOne> {
  

  @override
  void initState() {
    super.initState();
   
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form One'),
      ),
      
    );
  }
}

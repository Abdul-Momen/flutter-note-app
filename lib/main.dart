import 'package:flutter/material.dart';
import 'package:flutter_note_app/screens/notes_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MyNotePage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note_model.dart';
import 'package:flutter_note_app/screens/notes_page.dart';
import 'package:flutter_note_app/services/note_services.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter_note_app/main.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  _CreateNotePageState createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  String? title;
  String? descriptin;
  final _formKey = GlobalKey<FormState>();
  NoteService _noteService = new NoteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "title"),
                onSaved: (value) {
                  title = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "desCription"),
                onSaved: (value) {
                  descriptin = value;
                },
                validator: (v) {
                 if(v!.isEmpty){
                   return "this is not valid";
                 }
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {});

                      var newNote = NoteItem(
                          description: descriptin!,
                          title: title!,
                          crateAt: DateTime.now());
                      await _noteService.createNote(newNote);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyNotePage()),
                      );
                    }
                  },
                  child: Text("Save"))
            ],
          )),
    );
  }
}

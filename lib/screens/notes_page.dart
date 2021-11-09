import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note_model.dart';
import 'package:flutter_note_app/screens/create_page.dart';
import 'package:flutter_note_app/services/note_services.dart';
class MyNotePage extends StatefulWidget {
  const MyNotePage({Key? key}) : super(key: key);

  @override
  _MyNotePageState createState() => _MyNotePageState();
}

class _MyNotePageState extends State<MyNotePage> {
  NoteService _noteService = new NoteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),

      body: FutureBuilder(
        future: _noteService.getAllTodo(),
        builder: (ctx,snapshort){
          if(snapshort.hasError){
            return Center(
              child: Text(snapshort.error.toString()),
            );
          }else if(snapshort.hasData){
            var notes = snapshort.data as List<NoteItem>;
            return ListView.builder(

                itemCount:notes.length,
                itemBuilder:(ctx,index){
                  var note = notes[index];
                  return ListTile(
                    leading: Text("${note.id}"),
                    title: Text("${note.title}"),
                    trailing: InkWell(
                      onTap: () async{
                      await  _noteService.deleteTodo(note.id!);
                        setState(() {
                        });

                      },
                        child: Icon(Icons.delete)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("${note.description}"),
                      Text("${note.crateAt}")


                    ],),

                  );

            });
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  CreateNotePage()),
          );
        },
      ),
    );
  }
}



import 'package:flutter/foundation.dart';
import 'package:flutter_note_app/models/note_model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class NoteService {
  // this is the path in your app storage where the database files actually saved
  final String _dbPath = 'db/todo.db';

  DatabaseFactory dbFactory= kIsWeb? databaseFactoryWeb: databaseFactoryIo;

  /// This method creates a new Todo Item
  Future createNote(NoteItem newTodo) async {
    ///gets a database instance
    ///
    Database db = await dbFactory.openDatabase(_dbPath);

    /// gets the main data store
    final store = StoreRef.main();

    /// saves the data to the store
    await store.add(db, newTodo.toJson());
  }

  Future<List<NoteItem>> getAllTodo() async {
    Database db = await dbFactory.openDatabase(_dbPath);
    final store = StoreRef.main();

    ///gets all data from data store as RecordSnapshot
    final result = await store.find(db);

    /// maps a RecordSnapshot to a TodoItem and assigns the snapshot key as todo id
    return result.map((e) {
      var todo = NoteItem.fromJson(e.value);
      todo.id = e.key;
      return todo;
    }).toList();
  }

  Future<NoteItem> getTodo(int id) async {
    Database db = await dbFactory.openDatabase(_dbPath);
    final store = StoreRef.main();

    /// finds data from the datastore by certain clause
    /// in this case, by key
    final finder = Finder(filter: Filter.byKey(id));
    final result = await store.find(db, finder: finder);

    return NoteItem.fromMap(result.first.value);
  }

  Future updateTodo(int id, NoteItem updatedTodo) async {
    Database db = await dbFactory.openDatabase(_dbPath);
    final store = StoreRef.main();
    final finder = Finder(filter: Filter.byKey(id));
    ///updates the found todo
    await store.update(db, updatedTodo.toJson(), finder: finder);
  }

  Future deleteTodo(int id) async {
    Database db = await dbFactory.openDatabase(_dbPath);
    final store = StoreRef.main();
    final finder = Finder(filter: Filter.byKey(id));

    /// deletes the found todo
    await store.delete(db, finder: finder);
  }
}

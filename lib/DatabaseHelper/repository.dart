
 import 'package:flutter_note_app_bloc/DatabaseHelper/connection.dart';
import 'package:flutter_note_app_bloc/DatabaseHelper/tables.dart';
import 'package:flutter_note_app_bloc/Models/notes.dart';

class Repository{
   final DatabaseHelper databaseHelper = DatabaseHelper();

   //Get Notes
   Future<List<Notes>> getNotes()async{
     final db = await databaseHelper.initDatabase();
     final List<Map<String,Object?>> notes = await db.query(Tables.noteTableName);
     return notes.map((e) => Notes.fromMap(e)).toList();
   }

   // Add Note
   Future<int> addNote(Notes notes)async{
     final db = await databaseHelper.initDatabase();
     return db.insert(Tables.noteTableName, notes.toMap());
   }

   // Update Note
   Future<int> updateNote (Notes notes)async{
     final db = await databaseHelper.initDatabase();
     return db.update(Tables.noteTableName, notes.toMap(), where: "noteId = ?", whereArgs: [notes.noteId]);
   }

   //Delete Note
   Future<int> deleteNote(int id)async{
     final db = await databaseHelper.initDatabase();
     return db.delete(Tables.noteTableName,where: "noteId =?", whereArgs: [id]);
   }

   //Get Note By ID
   Future<Notes> getNoteById(int id)async{
     final db = await databaseHelper.initDatabase();
     final note = await db.query(Tables.noteTableName,where: "noteId = ?",whereArgs: [id]);
     if(note.isNotEmpty){
       return Notes.fromMap(note.first);
     }else{
       throw Exception("Note $id not found");
     }
   }

 }
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb{
  static late Database database;
 static String _tablename="mynotes";

  MyDb(){
    open();
  }

  static Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

   // print(path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db
     WidgetsFlutterBinding.ensureInitialized();
    database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db,int version) {
          // When creating the db, create the table
          return db.execute('''

                  CREATE TABLE IF NOT EXISTS $_tablename( 
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        title TEXT NOT NULL,
                        description TEXT
                        
                    );

                    //create more table here
                
                ''');
        });
  }

  static addNote(String title, String description){
    open();
    MyDb.database.rawInsert("INSERT INTO $_tablename (title, description) VALUES (?, ?);",
        [title, description]);
  }


  static Future<Map<dynamic, dynamic>?> getNote(int uid) async {
    open();
    List<Map> maps = await database.query(_tablename,
        where: 'id = ?',
        whereArgs: [uid]);
    //getting student data with roll no.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;

  }

  static Future<List<Map<String,dynamic>>> getAllNote() async {
    open();
     return await database.query(_tablename);
    //getting student data with roll no.
    // if (maps.length > 0) {
    //   return maps;
    // }
    // return null;
  }

  static Future<void> deleteNote(int id) async{
    open();
    database.delete(_tablename,where: 'id = ?',whereArgs: [id]);
  }

}
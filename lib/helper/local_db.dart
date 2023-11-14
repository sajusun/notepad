
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
  // add a single note method
  static addNote(String title, String description){
    open();
    MyDb.database.rawInsert("INSERT INTO $_tablename (title, description) VALUES (?, ?);",
        [title, description]);
  }
  //get note information by id
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
  // get all note method
  static Future<List<Map<String,dynamic>>> getAllNote() async {
    open();
     return await database.query(_tablename);
    //getting student data with roll no.
    // if (maps.length > 0) {
    //   return maps;
    // }
    // return null;
  }
  // delete note by id method
  static Future<bool> deleteNote(int id)  {
    open();
    Future<int> mgs=database.delete(_tablename,where: 'id = ?',whereArgs: [id]);
     var result=mgs.then((value) {
      if(value>0){return true;}else{return false;}
    });
     return result;
  }
//   update note info by id
  static Future<void> updateNote(Map<String, dynamic> data, int id) async{
    open();
    database.update(_tablename,data, where: 'id = ?',whereArgs: [id]);

  }

}
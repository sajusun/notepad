import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:notebook/helper/local_db.dart';

class FileManager{

//   final String _fileName ="text.txt";
// //   get method for getting file path for local storage
//  Future<String> get _filePath async {
// final dir = await getApplicationCacheDirectory();
// return dir.path;
// }
//    writeData(dynamic object) async {
//     for (int i = 0; i < object.length; i++) {
//      generateFile(object, i);
//     }
//
//  }
//
//  Future<void> generateFile(object, int i) async {
//     final filename = "$_filePath/${object[i]['title']}";
//     var file = await File(filename).writeAsString("""
// ${object[i]['creationTime']}\n
// ${object[i]['modifiedTime']}\n
// ${object[i]['description']}""");
//     print(file);
//   }

Future<String> ExternalDir() async {
  var status =await Permission.storage.status;
  if(!status.isGranted){
    await Permission.storage.request();
  }
  var dir = Directory("/storage/emulated/0/com.Notebook.notes");
  //final dir= await getExternalStorageDirectory();
  await Directory(dir.path).create(recursive: true);
  return dir.path;
}

  Future<String> createDir() async {
    //var directory = await Directory('notes').create(recursive: true);
    var status =await Permission.storage.status;
    if(!status.isGranted){
      await Permission.storage.request();
    }

    var dir = Directory("/storage/emulated/0/com.Notebook.notes");
    var directory = await Directory("${dir.path}/notes").create(recursive: true);
    return directory.path;
  }

// reading dirrectory where notes r exists
  Future<void> readDir() async {
    String cDir=await createDir().then((value) => value);
    List<FileSystemEntity> files;
    final folder = Directory(cDir);
    files = folder.listSync(recursive: true, followLinks: false);
    for (var element in files) {
      readFile(element.path);
    }
  }

// read every files in notes directory
  readFile(String fileLocation) async {
    File file = File(fileLocation);
    file.readAsLines().then((value) {
      var desc = "";
      value.sublist(3).forEach((element) {
        desc += "$element \n";
      });
      // inserting import data in mysqlite db
      MyDb.importNote(value[0], value[1], value[2], desc);

    });
  }

//file write methods
  void filewrite() async {
    // var object = data();
    List<Map<String, dynamic>> object=[];
    MyDb.getAllNote().then((value) {
     // print(value);
      for (int i = 0; i < value.length; i++) {
        generateFile(value, i);
        print(value[i]);
      }
    });
  }

// generate text file for every object
  void generateFile(dynamic object, int i) async {
    final dirName = await createDir();
    final filename =
        "$dirName/${object[i]['title']}__${object[i]['id']}.txt";
    await File(filename).writeAsString("""
${object[i]['creationTime']}
${object[i]['modifiedTime']}
${object[i]['title']}
${object[i]['description']}""");
  }

}
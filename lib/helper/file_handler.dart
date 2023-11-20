import 'dart:io';
import 'package:flutter/physics.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:notebook/helper/local_db.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
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
  print(dir.path);
  return dir.path;
}

  Future<String> createDir() async {
    //var directory = await Directory('notes').create(recursive: true);
    var status =await Permission.storage.status;
    if(!status.isGranted){
      await Permission.storage.request();
    }
    // Directory _directory = Directory("");
    // if (Plat) {
    //   // Redirects it to download folder in android
    //   _directory = Directory("/storage/emulated/0/Download");
    // } else {
    //   _directory = await getApplicationDocumentsDirectory();
    // }

    //final dir = await getExternalStorageDirectory();
    var dir = Directory("/storage/emulated/0/com.Notebook.notes");
    var directory = await Directory("${dir.path}/notes").create(recursive: true);
    //print(dir.path);
    print(directory.path);
    return directory.path;
  }

// reading dirrectory where notes r exists
  Future<void> readDir() async {
    String cDir=await createDir().then((value) => value);
    List<FileSystemEntity> files;
    final folder = new Directory(cDir);
    files = folder.listSync(recursive: true, followLinks: false);
    files.forEach((element) {
      readFile(element.path);
    });
  }

// read every files in notes directory
  readFile(String fileLocation) async {
    File file = File(fileLocation);
    file.readAsLines().then((value) {
      var desc = "";
      print("\n");
      print("CreationTime : ${value[0]}");
      print("ModifiedTime : ${value[1]}");
      print("Title : ${value[2]}");

      value.sublist(3).forEach((element) {
        desc += "$element \n";
      });
      print("desc: $desc");
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
   // print(object);
   //  for (int i = 0; i < object.length; i++) {
   //    print(object);
   //    generateFile(object, i);
   //  }
  }

// generate text file for every object
  void generateFile(dynamic object, int i) async {
    final dirName = await createDir();
    final filename =
        "${dirName}/${object[i]['title']}-uid-${object[i]['id']}.txt";
    print(filename);
    await File(filename).writeAsString("""
${object[i]['creationTime']}
${object[i]['modifiedTime']}
${object[i]['title']}
${object[i]['description']}""");
  }

// object data format for test
//   dynamic data() async {
//     List<Map<String, dynamic>> data=[];
//     // [
//     //   {
//     //     "id": "01",
//     //     "title": "dart program",
//     //     "description": "write a dart program.",
//     //     "creationTime": "01/02/2023 10:30 am",
//     //     "modifiedTime": "01/02/2023 12:30 am"
//     //   },
//     //   {
//     //     "id": "02",
//     //     "title": "python program ",
//     //     "description": "data read in python console",
//     //     "creationTime": "01/02/2023 10:30 am",
//     //     "modifiedTime": "01/02/2023 12:30 am"
//     //   },
//     //   {
//     //     "id": "03",
//     //     "title": "Java hello world",
//     //     "description": "all java code \n in the second line",
//     //     "creationTime": "01/02/2023 10:30 am",
//     //     "modifiedTime": "01/02/2023 12:30 am"
//     //   },
//     //   {
//     //     "id": "04",
//     //     "title": "my hello program",
//     //     "description": "here is my hello fromgram in flutter",
//     //     "creationTime": "01/02/2023 10:30 am",
//     //     "modifiedTime": "01/02/2023 12:30 am"
//     //   },
//     // ];
//
//     await MyDb.getAllNote().then((value) {
//       print(value);
//       //data.addAll(value);
//     });
//     return data;
//   }
  // Future<void> dbdata() async {
  //   await MyDb.getAllNote().then((value) {
  //     print(value);
  //
  //   });
  //
  // }


}
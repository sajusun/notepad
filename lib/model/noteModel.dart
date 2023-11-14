import 'package:notebook/helper/local_db.dart';

class NoteModel{
  late int id;
  late String title;
  late String description;

  NoteModel({required this.id, required this.title, required this.description});
}

class NoteData{

static Future<List<NoteModel>> getData() async{
   List<NoteModel> noteList=[];
   MyDb.getAllNote().then((value) {
     for(int i=0;i<=value.length; i++){
       noteList.add(NoteModel(id: value[i]['id'], title: value[i]['title'], description: value[i]['description']));
   }
   });
   return noteList;
  }
}
import 'package:flutter/material.dart';
import 'package:notebook/helper/local_db.dart';

@immutable
class AddNote extends StatefulWidget {
  AddNote({this.isEditMode=false,this.id=0, this.title, this.description});
  bool isEditMode;
  String? title,description;
  int id;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _title=TextEditingController();
  TextEditingController _description=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEditMode){
      _title.text=widget.title.toString();
      _description.text=widget.description.toString();
    }
  }

  Widget button(){
    if(widget.isEditMode){
      return IconButton(onPressed: () async {
        bool result=await MyDb.updateNote({'title':_title.text,'description':_description.text},widget.id);
          print(result);
          if(result){Navigator.pop(context);}
      }, icon: Icon(Icons.check),);
    }else{
      return IconButton(onPressed: () async {
        bool result= await MyDb.addNote(_title.text, _description.text);
          if(result){Navigator.pop(context);}
      }, icon: Icon(Icons.save_outlined),);
    }
  }


  @override
  Widget build(BuildContext context) {
    MyDb();
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.chevron_left_rounded,color: Colors.cyanAccent,size: 24,)),
        title: TextFormField(
          controller: _title,
          maxLines: 1,
          decoration: InputDecoration(hintText: "Title",
          border: InputBorder.none),
          scrollPadding: EdgeInsets.all(20.0),
          keyboardType: TextInputType.multiline,
          autofocus: true,
        ),
        centerTitle: true,
        actions: [
        button(),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white54,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: TextFormField(
              controller: _description,
              maxLines: 9999,
              decoration: InputDecoration(hintText: "Note Description",
              border: InputBorder.none),
              scrollPadding: EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              autofocus: true,
            ),
          ),
        ),

      ),
    );
  }
}




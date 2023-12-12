import 'package:flutter/material.dart';
import 'package:notebook/helper/date_time.dart';
import 'package:notebook/helper/local_db.dart';


class AddNote extends StatefulWidget {
  AddNote({super.key, this.isEditMode=false,this.id=0, this.title, this.description});
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
        String title="";
        if(_title.text.isNotEmpty) {
          title=_title.text;
        }else{
          title="Untitled";
        }
        bool result=await MyDb.updateNote(title, _description.text, currentDateTime(), widget.id);
        if(result){Navigator.pop(context);}
      }, icon: const Icon(Icons.check),);
    }else{
      return IconButton(onPressed: () async {
        String title="Untitled";
        bool result;
        if(_title.text.isNotEmpty) {
          result = await MyDb.addNote(_title.text, _description.text, currentDateTime());
        }else{
          result = await MyDb.addNote(title, _description.text, currentDateTime());
        }
        if(result){Navigator.pop(context);
        }
      }, icon: const Icon(Icons.save_outlined),);
    }
  }


  @override
  Widget build(BuildContext context) {
    MyDb();
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.chevron_left_rounded,size: 24,)),
        title: TextFormField(
          controller: _title,
          maxLines: 1,
          decoration: const InputDecoration(hintText: "Title",
              border: InputBorder.none),
          scrollPadding: const EdgeInsets.all(20.0),
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: TextFormField(
              controller: _description,
              maxLines: 9999,
              decoration: const InputDecoration(hintText: "Note Description",
                  border: InputBorder.none),
              scrollPadding: const EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              autofocus: true,
            ),
          ),
        ),

      ),
    );
  }
}
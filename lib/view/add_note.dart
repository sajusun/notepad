import 'package:flutter/material.dart';
import 'package:notebook/helper/local_db.dart';

class AddNote extends StatelessWidget {
   AddNote({super.key});
   TextEditingController _title=TextEditingController();
   TextEditingController _description=TextEditingController();


   TextEditingController get title => _title;

  set title(TextEditingController value) {
    _title = value;
  }

   TextEditingController get description => _description;

   set description(TextEditingController value) {
     _description = value;
   }

  @override
  Widget build(BuildContext context) {
    MyDb();
    return  Scaffold(
      appBar: AppBar(title: Text("Add New Note"),centerTitle: true,),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey,
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              maxLines: 1,
              decoration: InputDecoration(hintText: "Note Title",),
              scrollPadding: EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              autofocus: true,
            ),
            Container(
              height: 300,
              child: SingleChildScrollView(
                child: TextFormField(
                  controller: _description,
                  maxLines: 10,
                  decoration: InputDecoration(hintText: "Note Description",),
                  scrollPadding: EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  autofocus: true,
                ),
              ),
            ),
          ElevatedButton(onPressed: (){
            MyDb.addNote(_title.text, _description.text);
          }, child: Text("Save Me"))
          ],
        ),

      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:notebook/helper/local_db.dart';
import 'package:notebook/view/add_note.dart';
void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
   // MyApp({super.key;});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotePad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:    MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() =>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   List<Map<String,dynamic>> items=[];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  void getNotes() async{
        items =await MyDb.getAllNote();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 10),() {
      setState(() {
        getNotes();
      });
    },);


    return Scaffold(
      appBar: AppBar(title:Text("NoteBook"),centerTitle: true,actions: [IconButton(icon: Icon(Icons.add), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote())) ;
      },)],),
      body: Container(
       height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: ListView.builder(
            itemCount:items.length,
            itemBuilder: (context, index){
              return   Card(
                child: ListTile(
                  leading: IconButton(onPressed: (){},icon: Icon(Icons.edit),),
                  title: InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>AddNote(isEditMode: true,id: items[index]['id'],title: items[index]['title'],description: items[index]['description'],)));
                    },
                      child: Text(items[index]['title'])),
                  trailing: IconButton(onPressed: () async {
                    try {
                     await MyDb.deleteNote(items[index]['id']);
                    } on Exception catch(e){
                      print("have some deleting error issus!");
                    }
                  },icon: Icon(Icons.delete),color: Colors.redAccent,),

                ),
              );

            }),
      ),
    );
  }

}

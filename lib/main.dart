import 'package:flutter/material.dart';
import 'package:notebook/helper/local_db.dart';
import 'package:notebook/view/add_note.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NotePad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
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
    Future.delayed(const Duration(milliseconds: 10),() {
      setState(() {
        getNotes();
      });
    },);


    return Scaffold(
      appBar: AppBar(title:const Text("NoteBook"),centerTitle: true,actions: [IconButton(icon:const Icon(Icons.add), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote())) ;
      },)],),
      body: SizedBox(
       height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: ListView.builder(
            itemCount:items.length,
            itemBuilder: (context, index){
              return   Card(
                child: ListTile(
                  leading: IconButton(onPressed: (){},icon:const Icon(Icons.edit),),
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
                      return Future(() => e);
                    }
                  },icon:const Icon(Icons.delete),color: Colors.redAccent,),

                ),
              );

            }),
      ),
    );
  }

}

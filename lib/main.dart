import 'package:flutter/material.dart';
import 'package:notebook/helper/date_time.dart';
import 'package:notebook/helper/local_db.dart';
import 'package:notebook/view/add_note.dart';
import 'package:notebook/widget/alert_dialog.dart';
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

print(currentDateTime());
    return Scaffold(
      appBar: AppBar(title:const Text("NoteBook"),centerTitle: true,
        actions: [IconButton(icon:const Icon(Icons.add,color: Colors.cyanAccent,size: 24,),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote())) ;
      },)],),
      body: SizedBox(
       height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: ListView.builder(
            itemCount:items.length,
            itemBuilder: (context, index){
              return   Card(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>AddNote(isEditMode: true,id: items[index]['id'],title: items[index]['title'],description: items[index]['description'],)));
                  },
                  child: ListTile(
                    leading: IconButton(onPressed: (){
                      noteInfoDialogBox(context, items[index]['creationTime'], items[index]['modifiedTime']);
                    },icon:const Icon(Icons.info),),
                    title: Text(items[index]['title']),
                    subtitle: Text(items[index]['creationTime']),
                    trailing: IconButton(onPressed: ()  {
                      deleteDialogBox(context, items[index]['id']);
                    },icon:const Icon(Icons.delete),color: Colors.redAccent,),

                  ),
                ),
              );

            }),
      ),
    );
  }

}

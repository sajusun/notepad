import 'package:flutter/material.dart';
import 'package:notebook/helper/local_db.dart';
import 'package:notebook/model/noteModel.dart';
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
      title: 'My NotePad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:    MyHomePage(title: 'My NotePad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() =>_MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   List<Map<String,dynamic>> items=[];


  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 1),() {
      setState(() {
        MyDb.getAllNote().then((value) {
          items = value;
        });
        // });
      });
    },);
    return Scaffold(
      appBar: AppBar(title:Text("Note Book"),actions: [IconButton(icon: Icon(Icons.add), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote())) ;
      },)],),
      body: Container(
       height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: ListView.builder(
            itemCount:items.length,
            itemBuilder: (context, index){
              return   ListTile(
                leading: IconButton(onPressed: (){},icon: Icon(Icons.edit),),
                title: InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote()));
                    // AddNote().description=items[index]['description'];
                    // AddNote().title=items[index]['title'];
                  },
                    child: Text(items[index]['title'])),
                trailing: IconButton(onPressed: (){
                  MyDb.deleteNote(items[index]['id']);
                },icon: Icon(Icons.delete),),

              );

            }),
      ),
    );
  }

}

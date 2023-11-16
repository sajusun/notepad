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
   bool isSearch=false;
   TextEditingController searchText=TextEditingController();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void getNotes() async{
        items =await MyDb.getAllNote();
  }
  Widget searchWidget(bool search){
     if(search){
       return TextFormField(
         onTapOutside: (pointer){
           FocusManager.instance.primaryFocus?.unfocus();
         },
         textInputAction: TextInputAction.search,
         controller: searchText,
         maxLines: 1,
         decoration: InputDecoration(hintText: "Search", border: InputBorder.none),
         scrollPadding: EdgeInsets.all(20.0),
         keyboardType: TextInputType.text,
         autofocus: true,
         onChanged: (value){
           searchData(searchText.text);
         },
       );
     }else{
       return const Text("NoteBook");
     }
  }

  Future<void> searchData(searchText) async {
     var result = await MyDb.searchNote(searchText);
     items=result;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10),() {
      setState(() {
        if(isSearch) {
          searchData(searchText.text);
        }else{
          getNotes();
        }

      });
    },);

    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        isSearch=!isSearch;
        if(!isSearch){
          searchText.text="";
        }

      }, icon: Icon(Icons.search_rounded)),
        title:searchWidget(isSearch),centerTitle: true,
        actions: [IconButton(icon:const Icon(Icons.add_box_outlined,size: 24,),
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

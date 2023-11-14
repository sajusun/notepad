import 'package:flutter/material.dart';

import '../helper/shared_pref.dart';

class shared extends StatefulWidget {
  const shared({super.key});

  @override
  State<shared> createState() => _sharedState();
}

class _sharedState extends State<shared> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text("Note Book")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [

            Center(
              child: Text("notebook"),
            ),
            Center(
              child: SharedPref.isLogined()?Text("now i am logined!"):Text("now i am logout please login!"),
            ),
            SharedPref.isLogined()?
            ElevatedButton(onPressed: (){
              SharedPref.loginStatus(false);
              setState(() {
              });
            }, child: Text("logout")):
            ElevatedButton(onPressed: (){
              SharedPref.loginStatus(true);
              setState(() {
              });
            }, child: Text("login"))
          ],
        ),
      ),
    );
  }
}

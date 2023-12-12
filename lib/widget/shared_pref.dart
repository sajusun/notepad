// import 'package:flutter/material.dart';
// import '../helper/shared_pref.dart';
//
// class Shared extends StatefulWidget {
//   const Shared({super.key});
//
//   @override
//   State<Shared> createState() => _SharedState();
// }
//
// class _SharedState extends State<Shared> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(title:const Text("Note Book")),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//
//             const Center(
//               child: Text("notebook"),
//             ),
//             Center(
//               child: SharedPref.isLogined()?const Text("now i am logined!"):Text("now i am logout please login!"),
//             ),
//             SharedPref.isLogined()?
//             ElevatedButton(onPressed: (){
//               SharedPref.loginStatus(false);
//               setState(() {
//               });
//             }, child: const Text("logout")):
//             ElevatedButton(onPressed: (){
//               SharedPref.loginStatus(true);
//               setState(() {
//               });
//             }, child: const Text("login"))
//           ],
//         ),
//       ),
//     );
//   }
// }

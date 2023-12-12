
import 'package:flutter/material.dart';
import 'package:notebook/helper/local_db.dart';

Future<void> deleteDialogBox(BuildContext context, int id) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm to Delete'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Press Confirm to Delete This Note!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () async {
              try {
                await MyDb.deleteNote(id);

              } on Exception catch(e){
                return Future(() => e);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// note info dialog
Future<void> noteInfoDialogBox(BuildContext context, String creationDate, String modifiedDate) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text('Note Info',style: TextStyle(color: Colors.grey),)),
        content: SingleChildScrollView(
          child: Text(
              """  Note Create Date :
  $creationDate \n
  Note Last Modified : 
  $modifiedDate""" ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ],
      );
    },
  );
}

Future<void> alertBox(BuildContext context, String data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(child: Text('Note Info',style: TextStyle(color: Colors.grey),)),
        content: SingleChildScrollView(
          child: Text(data),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ],
      );
    },
  );
}
import 'dart:ui';

import 'package:flutter/material.dart';

class Uihelper{
  static dialogbox(BuildContext context,String title,String desc){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(title),
            content: Text(desc),
          );
        }
    );
  }
  static dailogsave(
      {required BuildContext context,required String Warning,required String des,
      required VoidCallback save,}){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(Warning,style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text(des),
            scrollable: true,
            actions: [
              TextButton(onPressed: save, child: Text("OK")),
            ],
          );
        }
    );
  }
  static dailogbox2(
      {required BuildContext context,required String Warning,required String des,
      required VoidCallback cancel,required VoidCallback save,}){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(Warning,style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text(des),
            scrollable: true,
            actions: [
              TextButton(onPressed: cancel, child: Text("cancel")),
              TextButton(onPressed: save, child: Text("OK")),
            ],
          );
        }
    );
  }
}
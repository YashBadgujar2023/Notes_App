import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Background/background.dart';
import 'package:notes_app/Model/Notes_model.dart';
import 'package:notes_app/bloc/Notes_Event.dart';
import 'package:notes_app/bloc/Notes_bloc.dart';
import 'package:notes_app/widget/Uihelper.dart';

class Add_Items extends StatefulWidget {
  const Add_Items({super.key});

  @override
  State<Add_Items> createState() => _Add_ItemsState();
}

class _Add_ItemsState extends State<Add_Items> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  bool canPop = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    desc.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: canPop,
        onPopInvoked: (bool value) {
      if (!canPop) {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Warning"),
                content: Text("Do you want to save the changes to this file"),
                scrollable: true,
                actions: [
                  TextButton(onPressed: (){
                    setState(() {
                      canPop = true;
                    });
                    if(title.text == '' )
                    {
                      Navigator.pop(context);
                      Uihelper.dialogbox(context, "Error", "Please Enter the data");
                      setState(() {
                        canPop = false;
                      });
                    }
                    else{
                      noteModel Notesmodel = noteModel(title: title.text.toString(),desc: desc.text.toString());
                      context.read<NotesBloc>().add(AddNotes(NoteModel: Notesmodel));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }, child: Text("Save")),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {
                      canPop = true;
                    });
                  }, child: Text("Don't Save")),
                  TextButton(onPressed:(){
                    Navigator.pop(context);
                  }, child: Text("Cancel")),
                ],
              );
            }
        );
      }
    },
      child: Scaffold(
        body: Background(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Warning"),
                                  content: Text("Do you want to save the changes to this file"),
                                  scrollable: true,
                                  actions: [
                                    TextButton(onPressed: (){
                                      setState(() {
                                        canPop = true;
                                      });
                                      if(title.text == '' )
                                      {
                                        Navigator.pop(context);
                                        Uihelper.dialogbox(context, "Error", "Please Enter the data");
                                        setState(() {
                                          canPop = false;
                                        });
                                      }
                                      else{
                                        noteModel Notesmodel = noteModel(title: title.text.toString(),desc: desc.text.toString());
                                        context.read<NotesBloc>().add(AddNotes(NoteModel: Notesmodel));
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }
                                    }, child: Text("Save")),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      setState(() {
                                        canPop = true;
                                      });
                                    }, child: Text("Don't Save")),
                                    TextButton(onPressed:(){
                                      Navigator.pop(context);
                                    }, child: Text("Cancel")),
                                  ],
                                );
                              }
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                            child: Icon(Icons.arrow_back_ios_new,size: MediaQuery.of(context).size.shortestSide*0.06,)
                        ),
                      ),
                      Customtextfield(title, "Title :)", 40),
                      Customtextfield(desc,"Description",30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              setState(() {
                canPop = true;
              });
              if(title.text == '')
              {
                Navigator.pop(context);
                Uihelper.dialogbox(context, "Error", "Please Enter the data");
                setState(() {
                  canPop = false;
                });
              }
              else{
                noteModel Notesmodel = noteModel(title: title.text.toString(),desc: desc.text.toString());
                context.read<NotesBloc>().add(AddNotes(NoteModel: Notesmodel));
                Navigator.pop(context);
              }
            },
            backgroundColor: Colors.black54,
            icon: Icon(Icons.save,color: Colors.white,),
            label: Text("Save",style: TextStyle(color: Colors.white),)
        ),
      ),
    );
  }
  Customtextfield(TextEditingController controller,String hintext,double size){
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      maxLines: null,
      style:  TextStyle(color: Colors.grey,fontSize: size),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.grey,fontSize: size),
      ),
    );
  }
}

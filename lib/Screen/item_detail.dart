import 'dart:developer';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Background/background.dart';
import 'package:notes_app/bloc/Notes_Event.dart';
import 'package:notes_app/bloc/Notes_bloc.dart';
import 'package:notes_app/bloc/Notes_state.dart';
import 'package:notes_app/widget/Uihelper.dart';

class Detail_Items extends StatefulWidget {
  final int dataindex;
  const Detail_Items({super.key, required this.dataindex});

  @override
  State<Detail_Items> createState() => _Detail_ItemsState();
}

class _Detail_ItemsState extends State<Detail_Items> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  bool canPop = false;
  late int id_index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool value) {
        if (!canPop) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Warning"),
                  content: Text("Do you want to save the changes to this file"),
                  scrollable: true,
                  actions: [
                    TextButton(
                        onPressed: () {
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
                            Navigator.pop(context);
                            context.read<NotesBloc>().add(NotesUpdate(desc: desc.text.toString(), title:title.text.toString(), id:id_index));
                            Navigator.pop(context);
                          }
                        },
                        child: Text("Save")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          setState(() {
                            canPop = true;
                          });
                        },
                        child: Text("Don't Save")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                  ],
                );
              });
        }
      },
      child: Scaffold(
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if(state is NotesLoadingState)
            {
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is NotesLoadedState) {
              id_index = state.arrnotes[widget.dataindex].note_id!;
              return Background(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Warning"),
                                        content: Text(
                                            "Do you want to save the changes to this file"),
                                        scrollable: true,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
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
                                                  context.read<NotesBloc>().add(NotesUpdate(desc: desc.text.toString(), title:title.text.toString(), id:id_index));
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text("Save")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                setState(() {
                                                  canPop = true;
                                                });
                                              },
                                              child: Text("Don't Save")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel")),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .shortestSide *
                                        0.06,
                                  )),
                            ),
                            Customtextfield(title.. text = state.arrnotes[widget.dataindex].title.toString(), "Title :)", 40),
                            Customtextfield(desc.. text = state.arrnotes[widget.dataindex].desc.toString(), "Description", 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            else{
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
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
                context.read<NotesBloc>().add(NotesUpdate(desc: desc.text.toString(), title:title.text.toString(), id:id_index));
                Navigator.pop(context);
              }
            },
            backgroundColor: Colors.black54,
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Customtextfield(
      TextEditingController controller, String hintext, double size) {
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      maxLines: null,
      style: TextStyle(color: Colors.grey, fontSize: size),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.grey, fontSize: size),
      ),
    );
  }
}

import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Background/background.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/bloc/Notes_Event.dart';
import 'package:notes_app/bloc/Notes_bloc.dart';
import 'package:notes_app/bloc/Notes_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> itemscolor = [
    Colors.orange.shade300,
    Colors.blue.shade300,
    Colors.red.shade300,
    Colors.orange.shade200,
    Colors.blue.shade200,
    Colors.red.shade200,
    Colors.redAccent.shade200,
    Colors.lightGreen.shade200,
    Colors.blueAccent,
  ];
  int colorindex = 0;
  int selectindex = 0;
  bool? theme;
  String name = 'User';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotesBloc>().add(Fetchdata());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double shortside = MediaQuery.of(context).size.shortestSide;
    double longestside = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Background(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: shortside * 0.02),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          "Hello,${name}",
                          style: GoogleFonts.aBeeZee(
                              fontSize:
                                  shortside * 0.04 < 25 ? 25 : shortside * 0.04,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.values[0],
                        )),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                                MyAppRouteConstant.settingRouterName);
                          },
                          icon: Icon(
                            Icons.settings,
                            size: shortside * 0.05 < 30 ? 30 : shortside * 0.05,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "My Notes",
                      style: GoogleFonts.skranji(
                          fontSize:
                              shortside * 0.05 < 50 ? 50 : shortside * 0.05,
                          fontWeight: FontWeight.w900,
                          height: 2),
                    ),
                    Container(
                      height: height * 0.06,
                      margin: EdgeInsets.only(bottom: height * 0.01),
                      // height: height * 0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectindex == 0) {
                                  } else {
                                    selectindex = 0;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectindex == 0
                                        ? Colors.blue.withOpacity(0.8)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: selectindex == 1
                                        ? Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white54
                                                    : Colors.black54)
                                        : null),
                                child: Center(
                                    child: Text(
                                  "All",
                                  style: TextStyle(
                                      fontSize: shortside * 0.03 < 20
                                          ? 20
                                          : shortside * 0.03,fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectindex == 1) {
                                  } else {
                                    selectindex = 1;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: selectindex == 1
                                        ? Colors.blue.withOpacity(0.8)
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: selectindex == 0
                                        ? Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.white54
                                                    : Colors.black54)
                                        : null),
                                child: Center(
                                    child: Text(
                                  "Bookmark",
                                  style: TextStyle(
                                      fontSize: shortside * 0.03 < 20
                                          ? 20
                                          : shortside * 0.03,fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    selectindex == 1
                        ? Center(
                            child: Container(
                              // color: Colors.blue,
                              child: Text("Comming soon"),
                            ),
                          )
                        : BlocBuilder<NotesBloc, NotesState>(
                            builder: (context, state) {
                            if (state is NotesLoadingState) {
                              return Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            } else if (state is NotesLoadedState) {
                              return state.arrnotes.isNotEmpty
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      reverse: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: width > 600
                                                  ? (width / 200 > 7
                                                          ? 7
                                                          : width / 200)
                                                      .toInt()
                                                  : 2,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8),
                                      itemCount: state.arrnotes.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder: (_)=>Detail_Items(note: note)));
                                            GoRouter.of(context).pushNamed(
                                                MyAppRouteConstant
                                                    .detailRouterName,
                                                pathParameters: {
                                                  'dataindex': index.toString()
                                                });
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                padding: EdgeInsets.all(5),
                                                constraints: BoxConstraints(
                                                    maxHeight:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: itemscolor[Random()
                                                          .nextInt(itemscolor
                                                              .length)]
                                                      .withOpacity(0.6),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state
                                                          .arrnotes[index].title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: shortside *
                                                                      0.4 >
                                                                  25
                                                              ? 25
                                                              : shortside * 0.4,
                                                          height: 1.2,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.fade,
                                                    ),
                                                    SizedBox(height: 5,),
                                                    Flexible(
                                                        child: Text(
                                                            state
                                                                .arrnotes[index]
                                                                .desc
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: shortside *
                                                                            0.2 >
                                                                        18
                                                                    ? 18
                                                                    : shortside *
                                                                        0.2,
                                                                height: 1.1),
                                                            overflow:
                                                                TextOverflow
                                                                    .clip)),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return ElevatedButton(
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        NotesBloc>()
                                                                    .add(NotesDelete(
                                                                        id: state
                                                                            .arrnotes[index]
                                                                            .note_id!));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                height: height *
                                                                    0.1,
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .delete,
                                                                    ),
                                                                    Text(
                                                                      "Delete",
                                                                    ),
                                                                  ],
                                                                ),
                                                              ));
                                                        });
                                                  },
                                                  child: Icon(Icons.more_horiz),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: shortside * 0.5,
                                            height: shortside * 0.5,
                                            child: Image.asset(
                                                "assets/download.png"),
                                          ),
                                          Text(
                                            "No Data",
                                            style: TextStyle(
                                                fontSize: 30,fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Please Add the note to Show",
                                            style: TextStyle(
                                                fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            } else {
                              return Container();
                            }
                          }),
                    SizedBox(
                      height: height * 0.01,
                    )
                  ]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            developer.log("hello");
            GoRouter.of(context).pushNamed(MyAppRouteConstant.addRouterName);
            // context.go('/add');
          },
          backgroundColor: Colors.black54,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

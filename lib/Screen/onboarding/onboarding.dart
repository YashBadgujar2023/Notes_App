import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/Screen/Home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  late PageController _controller;
  var onboarding_image =[
    {
      "image":"assets/onBoarding_image/onboarding_1.png",
      "title":" Welcome to Your Note Pad",
      "desc":"Start jotting down your thoughts, ideas, and lists.",
    },
    {
      "image":"assets/onBoarding_image/onboarding_3.png",
      "title":" Capture Everything",
      "desc":"Quickly create notes with text.",
    },
    {
      "image":"assets/onBoarding_image/onboarding_2.png",
      "title":"Organize Your World",
      "desc":"Keep your notes organized with folders and labels.",
    },
  ];
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: onboarding_image.length,
          itemBuilder: (_,index){
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:   MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            index == onboarding_image.length-1 ? Container() : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      if(index == onboarding_image.length-1){
                                        log("login");
                                      }
                                      _controller.animateToPage(onboarding_image.length - 1, duration: Duration(milliseconds: 1000), curve: Curves.ease);
                                    },
                                    child: Text("skip",style: TextStyle(fontSize: 25,color: Colors.orange))),
                                Icon(Icons.arrow_forward_ios_sharp,color: Colors.orange,size: 15,)
                              ],
                            ),
                            Image.asset(onboarding_image[index]["image"].toString(),height: 300,fit: BoxFit.cover,),
                            SizedBox(
                              height: 20,
                            ),
                            Text(onboarding_image[index]["title"].toString(),style: TextStyle(fontSize: 28,fontWeight: FontWeight.w500),textAlign:TextAlign.center),
                            SizedBox(
                              height: 10,
                            ),
                            Text(onboarding_image[index]["desc"].toString(),style: TextStyle(fontSize: 18,),textAlign:TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(index == onboarding_image.length-1)
                          {
                            GoRouter.of(context).pushReplacementNamed(MyAppRouteConstant.homeRouterName);
                            getdata(true);
                          }
                          _controller.nextPage(duration: Duration(milliseconds: 500),curve: Curves.ease);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                              child: Text(index == onboarding_image.length-1 ? "Ready To Start" : "continue",style: TextStyle(fontSize:18,fontWeight: FontWeight.w500,color: Colors.white ),)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
  getdata(bool value)async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("onboarding", value);
  }
}

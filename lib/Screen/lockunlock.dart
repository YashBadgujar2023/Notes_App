import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Background/Lock.dart';
import 'package:notes_app/Background/Lockscreenbackground.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/widget/Uihelper.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Unlock extends StatefulWidget {
  const Unlock({super.key});

  @override
  State<Unlock> createState() => _UnlockState();
}

class _UnlockState extends State<Unlock> {
  int attempt = 0;
  bool fail = false;
  String? password;
  TextEditingController pin_controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pin_controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double shortside = MediaQuery.of(context).size.shortestSide;
    double longestside = MediaQuery.of(context).size.longestSide;
    final defaultPin = PinTheme(
        width: width > 700 ? shortside * 0.2 : shortside,
        height: width > 700 ? shortside * 0.2 : shortside * 0.2,
        textStyle: TextStyle(fontSize: shortside * 0.15,color: Colors.white70),
        decoration: BoxDecoration(
          color: Colors.blue.shade200.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.transparent,width: 2),
        )
    );
    return Scaffold(
      body: LockBackground(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: shortside * 0.05),
            width: double.infinity,
            child: SingleChildScrollView(
              child: fail == false ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.1,),
                  Text(
                    "Verification",
                    style: GoogleFonts.rowdies(
                        fontSize: shortside * 0.1,height: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.1,),
                  Text(
                    "Enter Pin Here",
                    softWrap: true,
                    style: GoogleFonts.modernAntiqua(
                        fontSize: 25,
                        height: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.05,),
                  Pinput(
                    length: 4,
                    defaultPinTheme: defaultPin,
                    autofocus: true,
                    controller: pin_controller,
                    keyboardType: TextInputType.phone,
                    focusedPinTheme: defaultPin.copyWith(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade900.withOpacity(0.5),
                        border: Border.all(color:Colors.red.withOpacity(0.5),width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onCompleted: (pin){
                      attempt++;
                      if(attempt == 3){
                        fail = true;
                      }
                      else {
                        log("password");
                        if(password == pin){
                          log("ok");
                          GoRouter.of(context).pushReplacementNamed(MyAppRouteConstant.homeRouterName);
                        }
                        else{
                          Uihelper.dailogsave(context: context, Warning: "Error", des: "Enter the Correct pin attempt = $attempt", save: (){
                            Navigator.pop(context);
                            pin_controller.clear();
                            setState(() {
                            });

                          });
                        }
                      }
                    },
                  ),
                ],
              ) : Container(
                child: Column(
                  children: [
                    SizedBox(height: shortside * 0.1,),
                    Text(
                      "Verification Failed",softWrap: true,
                      style: GoogleFonts.rowdies(
                          color: Colors.white70,
                          fontSize: shortside * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("All Attempt Are Failed try After Some time")
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
check()async{
  final SharedPreferences preferences =await SharedPreferences.getInstance();
  password = preferences.getString('password');
}
}

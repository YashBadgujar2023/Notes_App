

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/Screen/Lockchatsetting.dart';
import 'package:notes_app/widget/Uihelper.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Locksetting2 extends StatefulWidget {
  const Locksetting2({super.key});

  @override
  State<Locksetting2> createState() => _Locksetting2State();
}

class _Locksetting2State extends State<Locksetting2> {
  bool lock_disable = false;
  bool forgot_password = false;
  String? ispassword;

  TextEditingController year_controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    year_controller.dispose();
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
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.transparent,width: 2),
        )
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      ListTile(
                        hoverColor: Colors.blue.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        onTap: () {
                          Uihelper.dailogbox2(
                              context: context,
                              Warning: "Warning",
                              des: "You Want to Disable Lock",
                              cancel: () {
                                Navigator.pop(context);
                              },
                              save: () async{
                                setState(() {
                                  lock_disable = true;
                                  forgot_password = false;
                                  Navigator.pop(context);
                                });
                              });
                        },
                        leading: Icon(Icons.block_outlined),
                        title: Text("Lock disable"),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                      ListTile(
                        hoverColor: Colors.blue.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        onTap: () {
                          setState(() {
                            lock_disable = false;
                            forgot_password = true;
                          });
                        },
                        leading: Icon(Icons.lock_reset),
                        title: Text("Forgot Password"),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ],
                  ),
                ),
                forgot_password == false ?
                Container()
                    :
                Container(
                  margin: EdgeInsets.symmetric(horizontal: shortside * 0.05,vertical: shortside * 0.1),
                  child: Column(
                    children: [
                      TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: year_controller,
                        style: TextStyle(fontSize:12,color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Enter the year of birth",
                            filled: true,
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),
                      SizedBox(height: shortside * 0.1,),
                      CupertinoButton(
                          onPressed: ()async{
                            final SharedPreferences preferences = await SharedPreferences.getInstance();
                            String value = preferences.getString('birth')!;
                            if(value == year_controller.text.toString()){
                              GoRouter.of(context).pushNamed(MyAppRouteConstant.lockSettingRouterName);
                            }
                            else {
                              Uihelper.dailogsave(context: context, Warning: "Warning", des: "Enter the correct birth day date", save: (){Navigator.pop(context);});
                            }
                          },
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Text("Submit",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),


                lock_disable == false ?
                Container()
                    :
                Container(
                  margin: EdgeInsets.symmetric(vertical: shortside * 0.1 , horizontal: shortside * 0.05),
                  child: Column(
                    children: [
                      Text(
                        "Enter Pin Here",
                        softWrap: true,
                        style: GoogleFonts.modernAntiqua(
                            fontSize: 25,
                            height: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      Pinput(
                        length: 4,
                        defaultPinTheme: defaultPin,
                        focusedPinTheme: defaultPin.copyWith(
                          decoration: BoxDecoration(
                            color: Colors.red.shade200,
                            border: Border.all(color:Colors.red.withOpacity(0.5),width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onCompleted: (pin){
                          ispassword = pin;
                        },
                      ),
                      SizedBox(height: shortside * 0.05,),
                      CupertinoButton(
                          onPressed: ()async{
                            final SharedPreferences preferences = await SharedPreferences.getInstance();
                            String password = preferences.getString('password')!;
                            if(ispassword == password){
                              preferences.setBool("lock", false);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                            else{
                              log("wrong");
                              Uihelper.dailogsave(context: context, Warning: "Warning", des: "Enter the correct pin", save: (){
                                Navigator.pop(context);
                              });
                            }
                          },
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Text("Submit",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

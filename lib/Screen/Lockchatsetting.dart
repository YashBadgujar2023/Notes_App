import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Background/Lockscreenbackground.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/widget/Uihelper.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockSetting extends StatefulWidget {
  const LockSetting({super.key});

  @override
  State<LockSetting> createState() => _LockSettingState();
}

class _LockSettingState extends State<LockSetting> {
  bool selectve = false;
  bool _agreeToTerms = false;
  TextEditingController year_controller = TextEditingController();
  String password = "1";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.white38,width: 2),
      )
    );
   return Lockscreenbackground(
        child: Container(
          margin: EdgeInsets.all(shortside * 0.05),
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Lock",
                  style: GoogleFonts.rowdies(
                      color: Colors.red,
                      fontSize: shortside * 0.15,
                      fontWeight: FontWeight.bold),
                ),
                selectve == false
                    ? Column(
                        children: [
                          Text(
                            "Protect sensitive information with our Note Lock feature. Choose from device passcode or custom password for access. Locked notes are encrypted and inaccessible without correct credentials.",
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 25,
                                height: 1,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: shortside * 0.05,
                          ),
                          Text(
                            "Forgot Password? Data Loss:",
                            style: GoogleFonts.archivo(
                                color: Colors.white70,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "For security reasons, repeatedly incorrect password attempts will result in permanent deletion of all locked notes. This measure safeguards your sensitive information from unauthorized access.",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 25,
                                  height: 1,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: shortside * 0.1,
                          ),
                          CheckboxListTile(
                            title: const Text(
                              'I agree to the terms and conditions',
                              style: TextStyle(color: Colors.white),
                            ),
                            value: _agreeToTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                _agreeToTerms = value!;
                              });
                              if (_agreeToTerms == true) {
                                Uihelper.dailogsave(
                                    context: context,
                                    Warning: "Warning",
                                    des:
                                        "Repeated incorrect password attempts will delete all locked notes permanently.",
                                    save: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        selectve = true;
                                      });
                                    });
                              }
                            },
                          ),
                        ],
                      )
                    : Container(
                  child: Column(
                    children: [
                      Text(
                          "Enter the Pin",
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 25,
                              height: 1,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: shortside * 0.2,),
                      Pinput(
                        length: 4,
                          defaultPinTheme: defaultPin,
                        focusedPinTheme: defaultPin.copyWith(
                          decoration: BoxDecoration(
                            border: Border.all(color:Colors.red.withOpacity(0.5),width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onCompleted: (pin){
                          password = pin;
                        },
                      ),
                      SizedBox(height: shortside * 0.2,),
                      Text(
                          "Enter birth of year",
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 25,
                              height: 1,
                              fontWeight: FontWeight.w400)),
                      TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        controller: year_controller,
                        style: TextStyle(fontSize:12,color: Colors.white70),
                        decoration: InputDecoration(
                            hintText: "For example: 2000",
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            )
                        ),
                      ),
                      SizedBox(height: shortside * 0.1,),
                      CupertinoButton(
                          onPressed: (){
                            if(password == "" || year_controller.text.toString() == ""){
                              Uihelper.dailogsave(context: context, Warning: "Warning", des: "Enter the all detail", save: (){Navigator.pop(context);});
                            }
                            else if(password.length < 4 || year_controller.text.length < 4){
                              Uihelper.dailogsave(context: context, Warning: "Warning", des: "Enter the all detail", save: (){Navigator.pop(context);});
                            }
                            else {Uihelper.dailogsave(context: context, Warning: "Warning", des: "Confirm After that it can't Change", save: (){
                              check(password,true,year_controller.text.toString());
                              Navigator.pop(context);
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
                )
              ],
            ),
          ),
        ),
      );
  }
}
void check(String value,bool lock,String birth)async{
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("password",value);
  preferences.setString("birth",birth);
  preferences.setBool("lock",lock);
}

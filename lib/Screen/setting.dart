

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
class _SettingState extends State<Setting> {
  bool? lock;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double shortside = MediaQuery.of(context).size.shortestSide;
    double longestside = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(width * 0.05),
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.1,),
                Container(
                  width: shortside * 0.4,
                  height: shortside * 0.4,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  child: Icon(Icons.person,size: shortside * 0.3,),
                ),
                Text(
                  "User",
                  style: GoogleFonts.aBeeZee(
                      fontSize: shortside * 0.04 < 25 ? 25 : shortside * 0.04,
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.values[0],
                ),
                SizedBox(height:height * 0.1),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: ListTile(
                    hoverColor: Colors.blue.withOpacity(0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    onTap: ()async{
                      final SharedPreferences preferences =await SharedPreferences.getInstance();
                      lock = preferences.getBool('lock');
                      if(lock == true){
                        GoRouter.of(context).pushNamed(MyAppRouteConstant.lockSetting2RouterName);
                      }
                      else {
                        GoRouter.of(context).pushNamed(MyAppRouteConstant.lockSettingRouterName);
                      }
                    },
                    leading: Icon(Icons.lock_open_outlined),
                    title: Text("Lock"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

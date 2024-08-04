import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/Screen/Add_notes.dart';
import 'package:notes_app/Screen/Home_page.dart';
import 'package:notes_app/Screen/Lockchatsetting.dart';
import 'package:notes_app/Screen/Locksetting2.dart';
import 'package:notes_app/Screen/item_detail.dart';
import 'package:notes_app/Screen/lockunlock.dart';
import 'package:notes_app/Screen/onboarding/onboarding.dart';
import 'package:notes_app/Screen/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyAppRoute {
  static GoRouter goRouter(bool? isAuth,bool? lock) {
    GoRouter router = GoRouter(
      initialLocation:isAuth != true ? '/onboarding' : lock != true ?'/home' : '/unlock' ,
      routes: [
        GoRoute(
            name: MyAppRouteConstant.homeRouterName,
            path: '/home',
            pageBuilder: (context, state) {
              return MaterialPage(child: HomePage());
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.settingRouterName,
            path: '/setting',
            pageBuilder: (context, state) {
              return MaterialPage(child: Setting());
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.onboardingRouterName,
            path: '/onboarding',
            pageBuilder: (context, state) {
              return MaterialPage(child: onboarding());
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.detailRouterName,
            path: '/detail_note/:dataindex',
            pageBuilder: (context, state) {
              final dataIndex = int.parse(state.pathParameters['dataindex']!);
              return MaterialPage(child: Detail_Items(dataindex:dataIndex));
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.addRouterName,
            path: '/add',
            pageBuilder: (context, state) {
              return MaterialPage(child: Add_Items());
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.lockSettingRouterName,
            path: '/lockSetting',
            pageBuilder: (context, state) {
              return MaterialPage(child: LockSetting());
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.unlockRouterName,
            path: '/unlock',
            pageBuilder: (context, state) {
              return MaterialPage(child: Unlock());
            }
        ),
        GoRoute(
            name: MyAppRouteConstant.lockSetting2RouterName,
            path: '/locksetting2',
            pageBuilder: (context, state) {
              return MaterialPage(child: Locksetting2());
            }
        ),
      ],
      // redirect: (context,state)async{
      //   late var isauth;
      //   final SharedPreferences preferences = await SharedPreferences.getInstance();
      //   isauth = preferences.getBool("onboarding");
      //   log(isauth.toString() + "hiii");
      //   if(isauth == true){
      //     return '/home';
      //   }
      //   else{
      //     return "/";
      //   }
      // }
    );
    return router;
  }
}

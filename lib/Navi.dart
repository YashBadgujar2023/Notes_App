
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/Routes/app_routing_constant.dart';
import 'package:notes_app/Screen/Home_page.dart';
import 'package:notes_app/Screen/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navi extends StatefulWidget {
  const Navi({super.key});

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  bool? get;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    log("Navigator");
    log(get.toString());
    if (get == true) {
      GoRouter.of(context).pushReplacement(MyAppRouteConstant.homeRouterName);
    }
    else {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const onboarding()));
      GoRouter.of(context).pushReplacement(MyAppRouteConstant.onboardingRouterName);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  check()async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    get = preferences.getBool("onboarding");
  }
}

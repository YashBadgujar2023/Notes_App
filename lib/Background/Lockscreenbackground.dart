import 'dart:ui';

import 'package:flutter/material.dart';

class Lockscreenbackground extends StatelessWidget {
  final Widget? child;
  const Lockscreenbackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double shortside = MediaQuery.of(context).size.shortestSide;
    double longestside = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: shortside * 0.2,
              height: shortside * 0.2,
              color: Colors.cyan.shade600,
            ),
            Center(
              child: Container(
                width: shortside * 0.4,
                height: shortside * 0.4,
                  color: Colors.blue.shade700,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: width > 650 ? 200 : 100,sigmaY: 100),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black12,
              ),
            ),
            Center(
              child: Container(
                child: Icon(Icons.lock_open,size: shortside,color: Colors.white12,),
              ),
            ),
            SafeArea(
                child: child!
            ),
          ],
        ),
      ),
    );
  }
}

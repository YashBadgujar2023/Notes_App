import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double shortside = MediaQuery.of(context).size.shortestSide;
    double longestside = MediaQuery.of(context).size.longestSide;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
           Container(
             width: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       width: shortside * 0.3,
                       height: shortside * 0.3,
                       decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(50)
                       ),
                     ),
                     Container(
                       width: shortside * 0.2,
                       height: shortside * 0.2,
                       decoration: BoxDecoration(
                          color: Colors.blue[500],
                          borderRadius: BorderRadius.circular(50)
                       ),
                     ),
                   ],
                 ),
                 SizedBox(
                   width: double.infinity,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Container(
                         width: shortside * 0.4,
                         height: shortside * 0.4,
                         decoration: BoxDecoration(
                             color: Colors.blue[900],
                             borderRadius: BorderRadius.circular(40)
                         ),
                       ),
                     ],
                   ),
                 ),
                 Container()
               ],
             ),
           ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaY: width > 650 ? 200 : 100,sigmaX: width > 650 ? 200 : 100),
              child: Container(
                width: width,
                height: height,
              ),
            ),
            Container(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}

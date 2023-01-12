import 'dart:ui';

import 'package:flutter/material.dart';

class EventCardCalendar extends StatelessWidget {
  final String img;
  const EventCardCalendar({Key? key, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(25),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 255, 255, 1),

              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(img, height: 25, width: 25,),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}

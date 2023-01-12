import 'dart:ui';

import 'package:fitter/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../models/menu_option.dart';

class SingleCard extends StatelessWidget {

  final MenuOption menuOption;
  final double? width;
  const SingleCard({Key? key, required this.menuOption, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, menuOption.route);
      },
      child: Container(
        margin: EdgeInsets.all(25),
        width:  width ?? 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
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
                  Image.asset(menuOption.image, height: 50, width: 50,),
                  SizedBox(height: 10,),
                  Text(menuOption.name, style:  AppTheme.textoBotonesMenus,)
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}

import 'package:fitter/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StartPainter extends StatelessWidget {
  final int difficulty;
  const StartPainter({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row res = Row();
    switch(difficulty) {
      case 1: {
        // statements;
        res = Row(
          children: [
            Icon(Icons.star_rate_rounded, color: Colors.yellow,),
            Icon(Icons.star_rate_rounded, color: AppTheme.lightBlue,),
            Icon(Icons.star_rate_rounded, color: AppTheme.lightBlue,),
          ]

        );
      }
      break;
      case 2: {
        res = Row(
            children: [
              Icon(Icons.star_rate_rounded, color: Colors.yellow,),
              Icon(Icons.star_rate_rounded, color: Colors.yellow,),
              Icon(Icons.star_rate_rounded, color: AppTheme.lightBlue,),
            ]

        );
      }
      break;
      case 3: {
        res = Row(
            children: [
              Icon(Icons.star_rate_rounded, color: Colors.yellow,),
              Icon(Icons.star_rate_rounded, color: Colors.yellow,),
              Icon(Icons.star_rate_rounded, color: Colors.yellow,),
            ]

        );
      }
    }
    return res;
  }
}

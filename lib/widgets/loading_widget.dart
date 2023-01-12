import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Fitter.png', width: 150,),
        SpinKitCircle(
          duration: Duration(seconds: 3),
          size: 100,
          color: AppTheme.blue,
        )
      ],
    );
  }
}
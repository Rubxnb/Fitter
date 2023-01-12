import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class showError extends StatelessWidget {
  final bool error;
  final String text;
  const showError({
    Key? key, required this.error, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  error ? Column(children: [Text(text, style: AppTheme.errorMessage,), SizedBox(height: 20,)]):  Text('');
  }
}

bool inputOk(String v1, String v2) {

  return v1 != '' && v2 != '';
}

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomInputField extends StatelessWidget {

  final String hint;
  final String label;
  final TextInputType tipo;
  final TextEditingController controller;
  final IconData icon;

  const CustomInputField({
    Key? key, required this.label, required this.hint, required this.icon, required this.tipo, required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
        obscureText: tipo == TextInputType.visiblePassword ? true: false,
        autofocus: false,
        controller: controller,
        keyboardType: tipo,
        onChanged: (value) {
        },
        validator: (value) {
          if(value == null) return 'Este campo es requerido';
          return value.length < 3 ? 'Mínimo 3 letras' : null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: AppTheme.inputDecorationTheme(label, hint, icon)
    );
  }
}

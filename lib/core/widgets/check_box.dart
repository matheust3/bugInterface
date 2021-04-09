import 'package:assist_agro/core/util/app_fonts.dart';
import 'package:flutter/material.dart';

class CheckBox1 extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const CheckBox1({Key? key, required this.value, required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: this.onChanged,
      value: this.value,
      title: Text(
        'Mostrar senha',
        style: AppFonts.inputTextFildLabelText,
      ),
    );
  }
}

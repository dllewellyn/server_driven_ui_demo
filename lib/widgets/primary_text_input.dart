import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryTextInput extends StatelessWidget {
  const PrimaryTextInput(
      {Key key,
        @required this.controller,
        @required this.hintText,
        @required this.validator})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      validator: (v) => validator(v),
    );
  }
}

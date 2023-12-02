import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool isReadOnly;
  final TextEditingController textEditingController;
  final String labelText;
  const InputField({super.key, required this.isReadOnly, required this.textEditingController, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      style: const TextStyle(color: Colors.white),
      readOnly: isReadOnly,
      controller: textEditingController,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,
        focusColor: Colors.white,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Set border color
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Set focused border color
        ),
        labelStyle: const TextStyle(color: Colors.white),),
    )
    ;
  }
}

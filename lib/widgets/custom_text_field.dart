import 'package:flutter/material.dart';

class CustumTextField extends StatelessWidget {
  CustumTextField({required this.hintText,required this.inputType, this.onChanged});

  String hintText;
  TextInputType ? inputType;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: inputType,
        onChanged: onChanged,
        decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }


}

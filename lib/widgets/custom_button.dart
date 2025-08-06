import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.TextButton,required this.ColorButton,this.onTap});

  String TextButton;
  Color ColorButton;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: ColorButton,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(TextButton)),
      ),
    );
  }
}

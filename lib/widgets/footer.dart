import 'package:flutter/material.dart';

Container navigationButton(Color color1, Color color2, String text, Widget page, bool isPop, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color1, color2])
    ),
    child: TextButton(
      onPressed: () {
        if (!isPop) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        } else {
          Navigator.pop(context);
        }
      }, 
      child: Text(text)
    ),
  );
}

Row footerButtons(List<Widget> buttons, MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.max,
      spacing: 25,
      children: buttons
    );
  }
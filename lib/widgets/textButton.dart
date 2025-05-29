import 'package:flutter/material.dart';

Widget defaultTextButton(String text, Color color, VoidCallback? funcion) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: color, width: 0.5),
      borderRadius: BorderRadius.circular(8)
    ),
    height: 40, width: 80,
    child: TextButton(
      onPressed: funcion,
      child: Text(text, 
        style: TextStyle(
          color: Colors.cyan,
          decorationColor: Colors.cyan,
          decoration: TextDecoration.underline,
        ),
      ), 
    ),
  );
}
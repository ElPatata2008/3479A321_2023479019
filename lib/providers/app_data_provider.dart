import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() => _counter++;
  void decrementCounter() { if (_counter > 0) { _counter--; } }
  void resetCounter() { if (_counter != 0) { _counter = 0; } }

  String _usuario = "Rigoberto";
  String get usuario => _usuario;

  void changeUserToJuan() => _usuario = "Juan"; 
  void changeUserToDiego() => _usuario = "Diego"; 
  void changeUserToPedro() => _usuario = "Pedro"; 

}


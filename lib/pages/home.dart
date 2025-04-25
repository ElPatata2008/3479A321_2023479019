import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  String clickAssetImg = "assets/icons/click.svg";

  void _incrementCounter() { setState(() { _counter++; }); }

  void _decrementCounter() { setState(() { _counter--; }); }

  void _resetCounter() { setState(() { _counter = 0; }); }

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working in MyHomePage!");
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text( 'Laboratorio 4: Preparación',
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(clickAssetImg, 
                colorFilter: const ColorFilter.mode(
                  Colors.amberAccent, 
                  BlendMode.srcIn
                ),
              ),
              const Text('Ha presioando el botón esta cantidad de veces:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          footerButtons(),
        ],
      ),
    );
  }

  Row footerButtons() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 25,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton( onPressed: _incrementCounter, icon: Icon(Icons.add) ),
            IconButton( onPressed: _decrementCounter, icon: Icon(Icons.remove) ),
            IconButton( onPressed: _resetCounter,     icon: Icon(Icons.restore) ),
        ]);
  }
}
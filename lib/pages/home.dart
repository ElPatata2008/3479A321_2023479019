import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab3/widgets/footer.dart';
import 'package:logger/logger.dart';
import 'package:lab3/pages/pages_manager.dart';

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

  void _pageCheck() {
    if (_counter % 2 == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ListContent()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("Logger is working in MyHomePage!");
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text( 'Laboratorio 5: Navegación',
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.all(8),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(onPressed: _incrementCounter, icon: Icon(Icons.add)),
                    IconButton(onPressed: _decrementCounter, icon: Icon(Icons.remove)),
                    IconButton(onPressed: _resetCounter, icon: Icon(Icons.restore)),
                    IconButton(onPressed: _pageCheck, icon: Icon(Icons.arrow_forward_rounded)),
                  ],
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [ 
          footerButtons([
            navigationButton(Colors.blueAccent, Colors.cyan, "List Content", ListContent(), false, context)
          ], 
          MainAxisAlignment.end), 
        ],
      ),
    );
  }

  

  
  
}
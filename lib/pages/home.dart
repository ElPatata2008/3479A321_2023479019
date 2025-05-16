import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab3/providers/app_data_provider.dart';
import 'package:lab3/widgets/footer.dart';
import 'package:logger/logger.dart';
import 'package:lab3/pages/pages_manager.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  
  @override
  State<MyHomePage> createState() {
    print("createState()");
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  String clickAssetImg = "assets/icons/click.svg";

  void _pageCheck() {
    if (context.read<AppData>().counter % 2 == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ListContent()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
    }
  }

  @override
  void initState() {
    print("iniState() called");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies() called");
    super.didChangeDependencies();
  }

  @override
  void setState(VoidCallback fn) {
    context.read<AppData>().counter;
    super.setState(fn);
  }

  @override
  void deactivate() {
    print("deactivate() called");
    super.deactivate();
  }

  @override
  void dispose() {
    print("dispose() called");
    super.dispose();
  }

  @override
  void reassemble() {
    print("reassemble() called");
    context.read<AppData>().counter;
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    // logger.d("Logger is working in MyHomePage!");
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text( 'Laboratorio 6: Providers',
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Bienvenido/a de nuevo\n ${context.read<AppData>().usuario}",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
                SizedBox(height: 25,),
                SvgPicture.asset(clickAssetImg, 
                  colorFilter: const ColorFilter.mode(
                    Colors.amberAccent, 
                    BlendMode.srcIn
                  ),
                ),
                const Text('Ha presioando el botón esta cantidad de veces:'),
                Text(
                  '${context.read<AppData>().counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(onPressed: () => setState(context.read<AppData>().incrementCounter), icon: Icon(Icons.add)),
                    IconButton(onPressed: () => setState(context.read<AppData>().decrementCounter), icon: Icon(Icons.remove)),
                    // IconButton(onPressed: context.read<AppData>().resetCounter, icon: Icon(Icons.restore)),
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab3/providers/app_data_provider.dart';
import 'package:lab3/pages/pages_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  late TabController _tabController;
  Color _appBarColor = Colors.amberAccent; 
  double t = 0.7;
  
  String clickAssetImg = "assets/icons/click.svg";

  // void _pageCheck() {
  //   if (context.read<AppData>().counter % 2 == 0) {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const ListContent()));
  //   } else {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
  //   }
  // }

  void appBarColor() {
    switch (_tabController.index) {
      case 0: _appBarColor = Colors.amberAccent; break;
      case 1: _appBarColor = Colors.redAccent; break;
      case 2: _appBarColor = Colors.blueAccent; break;
    }
  }


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        appBarColor();
        context.read<AppData>().usuario;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    context.read<AppData>().counter;
  }

  @override
  void reassemble() {
    context.read<AppData>().counter;
    context.read<AppData>().usuario;
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    // logger.d("Logger is working in MyHomePage!");
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _appBarColor,
          title: Text( 'Laboratorio 7: Persistencia',
            style: TextStyle(
              color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            controller: _tabController,
            dividerColor: Colors.white,
            dividerHeight: 2.5,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.white70,
            indicator: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
              ),
              color: Colors.white24,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.home, color: Colors.white,),),
              Tab(icon: Icon(Icons.list, color: Colors.white,),),
              Tab(icon: Icon(Icons.adb_outlined, color: Colors.white,),),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [ 
            Center(
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
                      colorFilter: ColorFilter.mode(
                        _appBarColor, 
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
                        IconButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            bool canReset = prefs.getBool("isResetEnabled") ?? false;
                            if (canReset) { setState(context.read<AppData>().resetCounter); }
                          }, 
                          icon: Icon(Icons.restore)),
                        // IconButton(onPressed: _pageCheck, icon: Icon(Icons.arrow_forward_rounded)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListContent(),
            About(appBarColor: _appBarColor,),
          ]
        ),
        
        // persistentFooterButtons: [ 
        //   footerButtons([
        //     navigationButton(Colors.blueAccent, Colors.cyan, "List Content", ListContent(), false, context)
        //   ], 
        //   MainAxisAlignment.end), 
        // ],
      ),
    );
  }

  

  
  
}
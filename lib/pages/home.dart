import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
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
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;

  Color _appBarColor = Colors.amberAccent; 
  double t = 0.7;
  String _imageUrl = 'https://picsum.photos/250?image=0';
  String clickAssetImg = "assets/icons/click.svg";
  // var _imagePath = '';

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

  void _getNewImage() async {
    final newImageUrl = 'https://picsum.photos/250?image=${context.read<AppData>().counter}';

    try {
      final response = await http.head(Uri.parse(newImageUrl));
      if (response.statusCode == 200 || response.statusCode == 404) {
        setState(() => _imageUrl = newImageUrl);
      } else {
        setState(() => _imageUrl = '');
      }
    } catch (e) {
      setState(() => _imageUrl = '');
    }
  }

  Future<void> _loadCameras() async {
    cameras = await availableCameras();
    setState(() => firstCamera = cameras.first);
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
  void reassemble() {
    context.read<AppData>().counter;
    context.read<AppData>().usuario;
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    // var logger = Logger();
    // logger.d("Logger is working in MyHomePage!");
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Text( 'Laboratorio 9: Cámara',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Bienvenido/a de nuevo\n ${context.read<AppData>().usuario}",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
                SizedBox(height: 10,),
                SvgPicture.asset(clickAssetImg, 
                  colorFilter: ColorFilter.mode(
                    _appBarColor, 
                    BlendMode.srcIn
                  ),
                ),
                const Text('Ha presioando el botón esta cantidad de veces:'),
                Text('${context.read<AppData>().counter}',
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
                      icon: Icon(Icons.restore)
                    ),
                    // IconButton(onPressed: _pageCheck, icon: Icon(Icons.arrow_forward_rounded)),
                  ],
                ),
                TextButton(
                  child: const Text("Sacar una foto"),
                  onPressed: () async {
                    await _loadCameras();
                    _getCameraImage(context, firstCamera);
                    // final result = await _getCameraImage(context, firstCamera);
                    // setState(() => _imagePath = result);
                  }, 
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    color: Colors.black26,
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Colors.amberAccent),
                            ),
                            child: Image.network(_imageUrl.isNotEmpty ? _imageUrl : '',
                              width: 250, height: 250,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Center(
                                child: Text("Failed to load image",
                                  style: TextStyle(
                                    color: Colors.red
                                  ),  
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _getNewImage(), 
                            child: Text("Refrescar imagen",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListContent(),
          About(appBarColor: _appBarColor,),
        ]
      ),
    );
  }

  Future<void> _getCameraImage(BuildContext context, CameraDescription firstCamera) async {

    final result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => PictureScreen(camera: firstCamera)
      )
    );

    if (!context.mounted) return;

    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(
    //       content: Image.file(File(result)),
    //       duration: Duration(seconds: 1),
    //     )
    //   );

    // return result;
  }
}


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lab3/pages/home.dart';
import 'package:lab3/providers/app_data_provider.dart';
import 'package:provider/provider.dart';

class PictureList extends StatefulWidget {
  const PictureList({super.key, this.newImage});

  final dynamic newImage;

  @override
  State<PictureList> createState() => _PictureListState();
}

class _PictureListState extends State<PictureList> {

  late List<dynamic> imagesTaken = [];
  late int gridSize = 2;

  Future<void> _loadImagesTaken() async {
    gridSize = context.read<AppData>().gridSize;
    imagesTaken = context.read<AppData>().imagesTaken;
    if (widget.newImage != null) imagesTaken.add(widget.newImage);
  }

  @override
  void initState() {
    _loadImagesTaken();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => MyHomePage())
            ), 
          ),
          backgroundColor: Colors.deepOrange,
          title: const Text("Imagenes tomadas"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50), 
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Imagenes: ${imagesTaken.length}",
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_circle_left_outlined),
                    onPressed: () => setState(() {
                      context.read<AppData>().decreaseGridSize();
                      gridSize = context.read<AppData>().gridSize;
                    })
                  ),
                  Text("Grid:\n$gridSize",
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_circle_right_outlined),
                    onPressed: () => setState(() {
                      context.read<AppData>().increaseGridSize();
                      gridSize = context.read<AppData>().gridSize;
                    })
                  ),
                ],
              ),
            )
          ),
        ),
        body: Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridSize),
            itemCount: imagesTaken.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrangeAccent
                )
              ),
              child: Image.file(
                File(imagesTaken[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
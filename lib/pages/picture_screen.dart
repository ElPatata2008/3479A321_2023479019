import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lab3/pages/pages_manager.dart';
import 'package:lab3/pages/picure_list.dart';

class PictureScreen extends StatefulWidget {
  const PictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {

  late CameraController _cameraController;
  late Future<void> _initCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera, 
      ResolutionPreset.medium
    );
    _initCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            SizedBox(
              width: 400, height: 400,
              child: FutureBuilder<void>(
                future: _initCameraControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_cameraController);
                  } else {
                    return const Center(child: CircularProgressIndicator(color: Colors.white,));       
                  }
                },
              ),
            ),          
            SizedBox(height: 25,),
            TextButton(
              child: Text("Sacar foto",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              onPressed: () async {
                try {
                  await _initCameraControllerFuture;
                  final image = await _cameraController.takePicture();
                  
                  if (!context.mounted) return;
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PictureList(newImage: image.path)
                    )
                  );

                  // await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => PreviewPictureScreen(imagePath: image.path)
                  //   )
                  // );
                  
                } catch (e) {
                  print(e);
                }
              }, 
            ),
          ],
        )
      ),
    );
  }
}

class PreviewPictureScreen extends StatelessWidget {
  const PreviewPictureScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vista Previa"),),
      body: Image.file(File(imagePath)),
    );
  }
}
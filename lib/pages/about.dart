import 'package:flutter/material.dart';
import 'package:lab3/pages/pages_manager.dart';
import 'package:lab3/widgets/footer.dart';

class About extends StatelessWidget {
  const About({super.key});

  final String normalFace = 'assets/imgs/normal.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Image.asset(normalFace, 
                height: 100,
                width: 100,
              ),
            ),
            Text("Fire in the hole"),
          ],
        )
      ),
      persistentFooterButtons: [
        footerButtons([
          navigationButton(Colors.blueAccent, Colors.cyanAccent, "List Content", ListContent(), true, context),
        ], 
        MainAxisAlignment.start)
      ],
    );
  }
}
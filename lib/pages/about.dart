import 'package:flutter/material.dart';
import 'package:lab3/pages/pages_manager.dart';
import 'package:lab3/providers/app_data_provider.dart';
import 'package:lab3/widgets/footer.dart';
import 'package:provider/provider.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final String normalFace = 'assets/imgs/normal.png';

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }


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
            Text("Cambiar nombre a:",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            TextButton(
              child: Text("Juan"),
              onPressed: () => setState(context.read<AppData>().changeUserToJuan), 
            ),
            TextButton(
              child: Text("Diego"),
              onPressed: () => setState(context.read<AppData>().changeUserToDiego), 
            ),
            TextButton(
              child: Text("Pedro"),
              onPressed: () => setState(context.read<AppData>().changeUserToPedro), 
            ),
            SizedBox(height: 20,),
            Text("Contador: ${context.read<AppData>().counter}")
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
import 'package:flutter/material.dart';
import 'package:lab3/pages/pages_manager.dart';
import 'package:lab3/pages/preferences.dart';
import 'package:lab3/providers/app_data_provider.dart';
import 'package:lab3/widgets/footer.dart';
import 'package:lab3/widgets/textButton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class About extends StatefulWidget {
  const About({super.key, required this.appBarColor});

  final Color appBarColor;

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final String normalFace = 'assets/imgs/normal.png';

  bool _isResetEnabled = false;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance(); 
    setState(() { 
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false; 
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Cambiar nombre a:",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultTextButton("Juan", widget.appBarColor, () => setState(context.read<AppData>().changeUserToJuan)),
                SizedBox(width: 10,),
                defaultTextButton("Diego", widget.appBarColor, () => setState(context.read<AppData>().changeUserToDiego)),
                SizedBox(width: 10,),
                defaultTextButton("Pedro", widget.appBarColor, () => setState(context.read<AppData>().changeUserToPedro)),
              ],
            ),
            SizedBox(height: 40,),
            Text("Contador: ${context.read<AppData>().counter}"),
            SizedBox(height: 40,),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Preferences()
                )
              ).then((_) {
                _loadPreferences();
              }), 
              child: Text("Preferencias")
            ),

            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Activities())), 
            child: Text("Actividades"))
          ],
        )
      ),
      // persistentFooterButtons: [
      //   footerButtons([
      //     navigationButton(Colors.blueAccent, Colors.cyanAccent, "List Content", ListContent(), true, context),
      //   ], 
      //   MainAxisAlignment.start)
      // ],
    );
  }
}
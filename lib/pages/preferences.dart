import 'package:flutter/material.dart';
import 'package:lab3/pages/home.dart';
import 'package:lab3/widgets/textButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {

  late bool _isResetEnabled = false;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance(); 
    setState(() { 
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false; 
    }); 
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isResetEnabled", _isResetEnabled);
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  String get _isResetEnabledText {
    if (_isResetEnabled) { return "Activado";}
    return "Desactivado";
  }

  void _invertIsResetEnabled() => _isResetEnabled = !_isResetEnabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Botón para reiniciar contador: $_isResetEnabledText" ),
            IconButton(
              icon: Icon(Icons.power_settings_new,
              size: 50,),
              onPressed: () => setState(_invertIsResetEnabled),
            ),
            SizedBox(height: 50,),
            defaultTextButton("Guardar", Colors.white, () {
              _savePreferences();
              Navigator.of(context).push( 
                MaterialPageRoute(
                  builder: (context) => MyHomePage()
                )
              ).then((_) {
                _loadPreferences();
              });
            }, )
          ],
        ),
      ),
    );
  }
}
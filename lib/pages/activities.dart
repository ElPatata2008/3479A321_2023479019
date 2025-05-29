import 'package:flutter/material.dart';
import 'package:lab3/entity/actividad.dart';
import 'package:lab3/services/database_helper.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {

  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Actividad> _actividades = [
    Actividad(0, "Mayo 12", "Correr"),
    Actividad(1, "Diciembre 25", "Navidad"),
    Actividad(2, "Mayo 29", "Entrega Lab 7")
  ];

  @override
  void didUpdateWidget(covariant Activities oldWidget) {
    reassemble();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    super.reassemble();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actividades"),
        actions: [
          TextButton(onPressed: () => setState(() {
              _actividades.add(Actividad(_actividades.last.id + 1, "Julio 21", "Termino de clases"));
            }), 
            child: Text("Add Random")
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _actividades.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ID"),
                        Text("Fecha"),
                        Text("Nombre")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_actividades[index].id.toString()),
                        Text(_actividades[index].fecha, textAlign: TextAlign.center), 
                        Text(_actividades[index].nombre, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Editar Elemento"),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_actividades[index].id.toString()),
                                  Text(_actividades[index].fecha),
                                  Text(_actividades[index].nombre)
                                ],
                              ),
                            ));
                          }, 
                          icon: Icon(Icons.edit)
                        ),
                        IconButton(onPressed: () => setState(() { _actividades.removeAt(index); }), 
                          icon: Icon(Icons.delete)
                        )
                      ],
                    )
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

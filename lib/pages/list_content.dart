import 'package:flutter/material.dart';
import 'package:lab3/pages/about.dart';
import 'package:lab3/pages/home.dart';
import 'package:lab3/widgets/footer.dart';

// final List<String> elements = [
//   'gohan: oal chabo',
//   'chabo: tengo hambre',
//   'gohan: mis fans daran like y comentaran masenki haa',
//   'chabo: tengo hambre we',
//   'gohan: MORITE POBRE',
//   'chabo: AAAAAAAAA'
// ];

final List<String> elements = [
  'Item 1',
  '¿Hola? ¿Esto funciona?',
  'Parece que si, quá alivio..',
  'Pensé que no podría lograr comunicación..'
];

class ListContent extends StatelessWidget {
  const ListContent({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(elements[index]),
          );
        },
      ),
      // persistentFooterButtons: [
      //   footerButtons([
      //     navigationButton(Colors.amberAccent, Colors.yellowAccent, "Home", MyHomePage(title: 'Flutter Demo Page'), true, context),
      //     navigationButton(Colors.redAccent, Colors.deepOrangeAccent, "About", About(), false, context),
      //   ], 
      //   MainAxisAlignment.spaceBetween)
      // ],
    );
  }
}
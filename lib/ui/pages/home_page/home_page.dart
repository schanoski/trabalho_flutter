import 'package:flutter/material.dart';
import 'package:trabalho_final_flutter/ui/components/drawer_components.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.school_outlined),
            Text('Universidade'),
          ],
        )
      ),
      drawer: const DrawerComponents(),
      body: Align(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Trabalho Final'),
              Text('Disciplina de Flutter'),
              Text('William Schanoski'),
              Text('RA: 00215064'),
              Text('Stefano Júlio Mariani'),
              Text('RA: 03018212')
            ]
        ),

      )


    );
  }
}
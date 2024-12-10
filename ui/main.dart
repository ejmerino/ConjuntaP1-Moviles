import 'package:flutter/material.dart';
import './ruleta_screen.dart'; // Importamos la pantalla de la ruleta

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruleta App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RuletaScreen(), // Llamamos a la pantalla de la ruleta
    );
  }
}

import 'package:flutter/material.dart';
import '../logic/ruleta_logic.dart'; // Importamos la lógica
import './ruleta_screen2.dart'; // Importamos la nueva pantalla


class RuletaScreen extends StatefulWidget {
  @override
  _RuletaScreenState createState() => _RuletaScreenState();
}

class _RuletaScreenState extends State<RuletaScreen> {
  List<int> numeros = [];
  final TextEditingController controlador = TextEditingController();
  Map<String, dynamic> resultados = {};
  String errorMensaje = ''; // Variable para mostrar los mensajes de error

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruleta App', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de la ruleta en la parte superior
            //Image.asset('assets/ruleta.png', height: 150, width: 150),
            SizedBox(height: 20), // Espacio entre la imagen y el contenedor de texto
            // Contenedor para el campo de texto
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: controlador,
                    decoration: InputDecoration(
                      labelText: 'Ingresa un número (0-36)',
                      errorText: errorMensaje.isEmpty ? null : errorMensaje,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      String input = controlador.text;
                      int? numero = int.tryParse(input);

                      // Validaciones
                      if (input.isEmpty) {
                        setState(() {
                          errorMensaje = 'Por favor ingresa un número.';
                        });
                      } else if (numero == null) {
                        setState(() {
                          errorMensaje = 'El valor ingresado no es un número válido.';
                        });
                      } else if (numero < 0 || numero > 36) {
                        setState(() {
                          errorMensaje = 'El número debe estar entre 0 y 36.';
                        });
                      } else if (numeros.length >= 10) {
                        setState(() {
                          errorMensaje = 'Ya has ingresado 10 números.';
                        });
                      } else {
                        setState(() {
                          // Si la validación pasa, agregar el número a la lista
                          numeros.add(numero);
                          errorMensaje = ''; // Limpiar mensaje de error
                        });
                        controlador.clear(); // Limpiar el campo de texto

                        // Calculamos automáticamente cuando haya 10 números
                        if (numeros.length == 10) {
                          setState(() {
                            resultados = RuletaLogic.procesarNumeros(numeros);
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Agregar número'),
                  ),
                  SizedBox(height: 10),
                  // Mostrar la cantidad de números ingresados
                  Text(
                    'Cantidad de números ingresados: ${numeros.length}/10',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Mostrar los resultados si están disponibles
            if (resultados.isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  children: [
                    Text('Cantidad de números impares: ${resultados['impares']}'),
                    Text('Promedio de los números pares (sin contar el 0): ${resultados['promedioPares']}'),
                    Text('Cantidad de números en la 2° docena: ${resultados['docena2']}'),
                    Text('Número más grande: ${resultados['maximo']}'),
                  ],
                ),
              ),
            ],
            SizedBox(height: 20),
            // Botón para redirigir a RuletaScreen2
            ElevatedButton(
              onPressed: () {
                // Redirige a RuletaScreen2
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RuletaScreen2()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Ingreso de números hasta el 36'),
            ),
          ],
        ),
      ),
    );
  }
}

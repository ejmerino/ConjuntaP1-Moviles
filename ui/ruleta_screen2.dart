import 'package:flutter/material.dart';
import '../logic/ruleta_logic.dart'; // Importamos la lógica

class RuletaScreen2 extends StatefulWidget {
  @override
  _RuletaScreen2State createState() => _RuletaScreen2State();
}

class _RuletaScreen2State extends State<RuletaScreen2> {
  List<int> numeros = [];
  final TextEditingController controlador = TextEditingController();
  Map<String, dynamic> resultados = {};
  String errorMensaje = ''; // Para mensajes de error

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingreso libre de Números', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen de la ruleta
            //Image.asset('assets/ruleta.png', height: 150, width: 150),
            SizedBox(height: 20), // Espacio entre la imagen y el contenedor
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
                    onChanged: (value) {
                      int? numero = int.tryParse(value);

                      // Si el número ingresado es 36, procesamos los números
                      if (numero != null && numero == 36) {
                        setState(() {
                          numeros.add(numero); // Agregamos el 36
                          resultados = RuletaLogic.procesarNumeros(numeros); // Calculamos los resultados
                          errorMensaje = ''; // Limpiamos cualquier mensaje de error
                        });
                        controlador.clear(); // Limpiamos el campo de texto
                      }
                    },
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
                      } else {
                        setState(() {
                          // Si la validación pasa, agregar el número a la lista
                          numeros.add(numero); // Agrega el número ingresado
                          errorMensaje = ''; // Limpiar mensaje de error
                        });
                        controlador.clear(); // Limpiar el campo de texto
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
                    'Cantidad de números ingresados: ${numeros.length}',
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
          ],
        ),
      ),
    );
  }
}

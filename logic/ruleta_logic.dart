class RuletaLogic {
  static Map<String, dynamic> procesarNumeros(List<int> numeros) {
    // Variables para almacenar los resultados
    int cantidadImpares = 0;
    int sumaPares = 0;
    int cantidadPares = 0;
    int cantidadDocena2 = 0;
    int maximo = 0;

    for (int numero in numeros) {
      if (numero % 2 != 0) {
        cantidadImpares++;
      } else if (numero != 0) { // No contar el 0 para el promedio de pares
        sumaPares += numero;
        cantidadPares++;
      }
      if (numero >= 13 && numero <= 24) {
        cantidadDocena2++;
      }
      if (numero > maximo) {
        maximo = numero;
      }
    }

    double promedioPares = cantidadPares > 0 ? sumaPares / cantidadPares : 0.0;

    // Retorna los resultados
    return {
      'impares': cantidadImpares,
      'promedioPares': promedioPares,
      'docena2': cantidadDocena2,
      'maximo': maximo,
    };
  }
}

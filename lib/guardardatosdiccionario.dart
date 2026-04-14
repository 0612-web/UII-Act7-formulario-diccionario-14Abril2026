import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Variable para simular el auto numérico
  static int _ultimoId = 0;

  // Agente para guardar/modificar el diccionario de empleados
  static void guardarEmpleado(String nombre, String puesto, double salario) {
    _ultimoId++; // Auto numérico
    
    Empleado nuevoEmpleado = Empleado(
      id: _ultimoId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );
    
    // Almacenamos en el diccionario
    datosEmpleado[_ultimoId] = nuevoEmpleado;
  }
}

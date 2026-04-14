import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleadosScreen extends StatelessWidget {
  const VerEmpleadosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la lista de valores (Empleados) del diccionario
    final empleados = datosEmpleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: empleados.isEmpty
          ? const Center(
              child: Text(
                'No hay empleados registrados aún.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: empleados.length,
              itemBuilder: (context, index) {
                final empleado = empleados[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade100,
                      child: Text(
                        empleado.id.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                    ),
                    title: Text(
                      empleado.nombre,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text('Puesto: ${empleado.puesto}'),
                        Text(
                          'Salario: \$${empleado.salario.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

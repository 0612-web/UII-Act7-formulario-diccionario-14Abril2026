import 'dart:io';

void main() async {
  print('=============================================');
  print(' 🤖 Agente Repositorio - Sincronización GitHub');
  print('=============================================');

  // Verificar si el proyecto ya fue inicializado con git
  final gitDir = Directory('.git');
  if (!gitDir.existsSync()) {
    print('\nℹ️  Inicializando repositorio git local...');
    await _ejecutarComando('git', ['init']);
  }

  // Comprobar remotos actuales
  final remotosActuales = await Process.run('git', ['remote', '-v'], runInShell: true);
  final textoRemotos = remotosActuales.stdout.toString();
  
  if (textoRemotos.isEmpty) {
    print('\nNo se ha detectado ningún repositorio remoto de GitHub.');
  } else {
    print('\nRemoto actual detectado:');
    print(textoRemotos.trim());
  }

  // Preguntar por el enlace de GitHub
  stdout.write('\n🔗 Introduce el enlace del repositorio de GitHub \n(Presiona Enter para omitir si ya está configurado): ');
  String idGithub = stdin.readLineSync() ?? '';
  idGithub = idGithub.trim();

  if (idGithub.isNotEmpty) {
    if (textoRemotos.contains('origin')) {
      print('ℹ️  Actualizando la URL del remoto origin...');
      await _ejecutarComando('git', ['remote', 'set-url', 'origin', idGithub]);
    } else {
      print('ℹ️  Añadiendo remoto origin...');
      await _ejecutarComando('git', ['remote', 'add', 'origin', idGithub]);
    }
  }

  // Preguntar por la rama
  stdout.write('\n🌿 ¿A qué rama deseas subir los cambios? (Deja en blanco para usar "main"): ');
  String rama = stdin.readLineSync() ?? '';
  rama = rama.trim();
  if (rama.isEmpty) {
    rama = 'main';
  }

  // Cambiar y forzar el nombre de la rama actual a la solicitada
  await _ejecutarComando('git', ['branch', '-M', rama]);

  // Preguntar por el commit
  stdout.write('\n📝 Introduce el mensaje del commit \n(O presiona Enter para usar "Actualización automática"): ');
  String mensajeCommit = stdin.readLineSync() ?? '';
  mensajeCommit = mensajeCommit.trim();
  if (mensajeCommit.isEmpty) {
    mensajeCommit = 'Actualización automática';
  }

  // Agregar archivos
  print('\n📦 Preparando archivos para enviar (git add .)...');
  await _ejecutarComando('git', ['add', '.']);

  // Generar el commit
  print('\n💾 Guardando el commit...');
  await _ejecutarComando('git', ['commit', '-m', mensajeCommit]);

  // Subir la rama a github
  print('\n🚀 Subiendo el código a GitHub (rama: $rama)...');
  int resultadoPush = await _ejecutarComando('git', ['push', '-u', 'origin', rama]);

  if (resultadoPush == 0) {
    print('\n✅ ¡Éxito! Tu proyecto ha sido guardado y subido correctamente a GitHub.');
  } else {
    print('\n❌ Hubo un inconveniente al hacer el push. Revisa la salida de la consola arriba.');
  }
}

/// Función de ayuda para ejecutar comandos asíncronos y mostrar su salida
Future<int> _ejecutarComando(String ejecutable, List<String> argumentos) async {
  var process = await Process.start(
    ejecutable, 
    argumentos, 
    runInShell: true,
  );
  
  // Imprimir stdout y stderr en vivo
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  
  return await process.exitCode;
}

import 'package:all_service/domain/entities/usuario.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerLogin = StateNotifierProvider< LogInController, bool >( (ref) => LogInController() );

class LogInController extends StateNotifier<bool> {
  LogInController() : super(false);

  Future<void> iniciarSesion( String email, String contrasena ) async {
    final user = Usuario(email: email, contrasena: contrasena);

    // TODO: Verificar si existe en la base de datos

    state = true;
  }
}
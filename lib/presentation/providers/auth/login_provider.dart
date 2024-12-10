import 'package:all_service/domain/entities/usuario.dart';
import 'package:all_service/presentation/providers/auth/user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerLogin = StateNotifierProvider< LogInController, bool >( (ref) {
  final userRepository = ref.watch( usuariosRepositoryProvider );

  return LogInController( iniciar: userRepository.authUser );
} );


typedef IniciarSesion = Future<bool>Function({required Usuario usuario});

class LogInController extends StateNotifier<bool> {
  final IniciarSesion iniciar;

  LogInController({
    required this.iniciar
  }) : super(false);

  Future<void> iniciarSesion( String email, String contrasena ) async {
    final user = Usuario(email: email, contrasena: contrasena);

    iniciar( usuario: user );

    state = await iniciar( usuario: user );
  }
}
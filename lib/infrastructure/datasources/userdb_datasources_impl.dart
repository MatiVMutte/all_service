import 'package:all_service/domain/datasources/user_datasource.dart';
import 'package:all_service/domain/entities/usuario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDbDatasource extends UserDataSource {

  final SupabaseClient _client = Supabase.instance.client;
  
  @override
  Future<bool> authUser({ required Usuario usuario }) async {
    try {
      if (usuario.email.isEmpty || usuario.contrasena.isEmpty) {
        throw Exception("Email y contraseña no pueden estar vacíos.");
      }

      final AuthResponse response = await _client.auth.signInWithPassword(
        email: usuario.email, 
        password: usuario.contrasena
      );

      return response.session != null;
    } catch (e) {
      return false;
    }
  }

  
}
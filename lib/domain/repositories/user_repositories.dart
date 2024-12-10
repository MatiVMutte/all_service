import 'package:all_service/domain/entities/usuario.dart';

abstract class UserRepositories {
  
  Future<bool> authUser({ required Usuario usuario });

}
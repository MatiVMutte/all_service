import 'package:all_service/domain/entities/usuario.dart';

abstract class UserDataSource {

  Future<bool> authUser({ required Usuario usuario });
  
}
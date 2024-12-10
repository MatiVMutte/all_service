import 'package:all_service/domain/datasources/user_datasource.dart';
import 'package:all_service/domain/entities/usuario.dart';
import 'package:all_service/domain/repositories/user_repositories.dart';

class UserDbRepositoriesImpl extends UserRepositories {

  final UserDataSource datasource;

  UserDbRepositoriesImpl(this.datasource);

  @override
  Future<bool> authUser({required Usuario usuario}) {
    return datasource.authUser(usuario: usuario);
  }
  
}
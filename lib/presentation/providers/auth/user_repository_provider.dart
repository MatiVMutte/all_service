import 'package:all_service/infrastructure/datasources/userdb_datasources_impl.dart';
import 'package:all_service/infrastructure/repositories/userdb_repositories_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usuariosRepositoryProvider = Provider( (ref) {
  return UserDbRepositoriesImpl( UserDbDatasource() );
}, );
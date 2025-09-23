import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/domain/entity/login_resonse_entity.dart';
import 'package:shopping_app/feature/auth/domain/entity/register_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/data-source/auth_data_source_contract.dart';
import 'package:shopping_app/feature/auth/data/repo/data-source/auth_data_source_impl.dart';
import 'package:shopping_app/feature/auth/domain/repo/repository/auth_repository_contract.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  const AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSourceContract _dataSource;

  @override
  Future<NetworkResult<LoginResonseEntity>> login(LoginParams request) {
    return _dataSource.login(request);
  }

  @override
  Future<NetworkResult<RegisterResponseEntity>> register(
    RegisterParams request,
  ) {
    return _dataSource.register(request);
  }
}

AuthRepositoryContract injectableAuthRepo() =>
    AuthRepositoryImpl(injectableAuthDataSource());

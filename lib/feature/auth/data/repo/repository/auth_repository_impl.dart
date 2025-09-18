import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:shopping_app/feature/auth/data/repo/data-source/auth_data_source_contract.dart';
import 'package:shopping_app/feature/auth/data/repo/data-source/auth_data_source_impl.dart';
import 'package:shopping_app/feature/auth/data/repo/repository/auth_repository_contract.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  const AuthRepositoryImpl(this._dataSource);

  final AuthRemoteDataSourceContract _dataSource;

  @override
  Future<NetworkResult<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) => _dataSource.register(request);
}

AuthRepositoryContract injectableAuthRepo() =>
    AuthRepositoryImpl(injectableAuthDataSource());

import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/api/auth_api.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:shopping_app/feature/auth/data/repo/data-source/auth_data_source_contract.dart';

class AuthDataSourceImpl implements AuthRemoteDataSourceContract {
  const AuthDataSourceImpl(this._authApi);
  final AuthApi _authApi;
  @override
  Future<NetworkResult<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async => await _authApi.register(request);
}

AuthRemoteDataSourceContract injectableAuthDataSource() =>
    AuthDataSourceImpl(AuthApi.instance);

import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/api/auth_api.dart';
import 'package:shopping_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:shopping_app/feature/auth/domain/entity/login_resonse_entity.dart';
import 'package:shopping_app/feature/auth/domain/entity/register_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/data-source/auth_data_source_contract.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';

class AuthDataSourceImpl implements AuthRemoteDataSourceContract {
  const AuthDataSourceImpl(this._authApi);
  final AuthApi _authApi;

  @override
  Future<NetworkResult<LoginResonseEntity>> login(LoginParams request) async {
    final dto = LoginRequestDto(
      email: request.email,
      password: request.password,
    );

    final result = await _authApi.login(dto);

    switch (result) {
      case NetworkSuccess<LoginResponseDto>():
        return NetworkSuccess<LoginResonseEntity>(result.data.toEntity());
      case NetworkFailure<LoginResponseDto>():
        return NetworkFailure<LoginResonseEntity>(result.errorMessage);
    }
  }

  @override
  Future<NetworkResult<RegisterResponseEntity>> register(
    RegisterParams request,
  ) async {
    final dto = RegisterRequestDto(
      name: request.name,
      email: request.email,
      password: request.password,
    );
    final result = await _authApi.register(dto);
    switch (result) {
      case NetworkSuccess<RegisterResponseDto>():
        return NetworkSuccess<RegisterResponseEntity>(result.data.toEntity());
      case NetworkFailure<RegisterResponseDto>():
        return NetworkFailure<RegisterResponseEntity>(result.errorMessage);
    }
  }
}

AuthRemoteDataSourceContract injectableAuthDataSource() =>
    AuthDataSourceImpl(AuthApi.instance);

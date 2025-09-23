import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/repo/repository/auth_repository_impl.dart';
import 'package:shopping_app/feature/auth/domain/entity/register_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/repository/auth_repository_contract.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';

class RegisterUseCase {
  final AuthRepositoryContract repository;

  RegisterUseCase(this.repository);

  Future<NetworkResult<RegisterResponseEntity>> call(RegisterParams params) {
    return repository.register(params);
  }
}

RegisterUseCase injectableRegisterUseCase() =>
    RegisterUseCase(injectableAuthRepo());

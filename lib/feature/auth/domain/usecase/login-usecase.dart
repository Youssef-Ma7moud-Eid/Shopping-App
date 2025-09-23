import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/repo/repository/auth_repository_impl.dart';
import 'package:shopping_app/feature/auth/domain/entity/login_resonse_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/repository/auth_repository_contract.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';

class LoginUseCase {
  final AuthRepositoryContract repository;

  LoginUseCase(this.repository);

  Future<NetworkResult<LoginResonseEntity>> call(LoginParams params) {
    return repository.login(params);
  }
}

LoginUseCase injectableLoginUseCase() => LoginUseCase(injectableAuthRepo());

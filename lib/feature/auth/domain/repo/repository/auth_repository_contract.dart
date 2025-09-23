import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/domain/entity/login_resonse_entity.dart';
import 'package:shopping_app/feature/auth/domain/entity/register_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';

abstract class AuthRepositoryContract {
  Future<NetworkResult<RegisterResponseEntity>> register(
    RegisterParams request,
  );
  Future<NetworkResult<LoginResonseEntity>> login(LoginParams request);
}

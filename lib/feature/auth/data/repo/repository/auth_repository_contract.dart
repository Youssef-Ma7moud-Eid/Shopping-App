import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';

abstract class AuthRepositoryContract {
  Future<NetworkResult<RegisterResponseDto>> register(
    RegisterRequestDto request,
  );
}

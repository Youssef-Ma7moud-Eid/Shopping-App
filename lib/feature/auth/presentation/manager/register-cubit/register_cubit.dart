import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:shopping_app/feature/auth/data/repo/repository/auth_repository_contract.dart';
import 'package:shopping_app/feature/auth/presentation/manager/register-cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repository) : super(InitialState());
  final AuthRepositoryContract _repository;
  Future<void> register(String name, String email, String pass) async {
    emit(LoadingRegister());
    var result = await _repository.register(
      RegisterRequestDto(name: name, email: email, password: pass),
    );
    switch (result) {
      case NetworkSuccess<RegisterResponseDto>():
        emit(SuccessRegister());
      case NetworkFailure<RegisterResponseDto>():
        emit(FauilreRegister());
    }
  }
}

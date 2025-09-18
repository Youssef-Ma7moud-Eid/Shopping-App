import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:shopping_app/feature/auth/data/repo/repository/auth_repository_contract.dart';
import 'package:shopping_app/feature/auth/presentation/manager/login-cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(InitialState());
  final AuthRepositoryContract _repository;
  Future<void> login(String email, String pass) async {
    emit(LoadingLogin());
    var result = await _repository.login(
      LoginRequestDto(email: email, password: pass),
    );
    switch (result) {
      case NetworkSuccess<LoginResponseDto>():
        emit(SuccessLogin());
      case NetworkFailure<LoginResponseDto>():
        emit(FauilreLogin());
    }
  }
}

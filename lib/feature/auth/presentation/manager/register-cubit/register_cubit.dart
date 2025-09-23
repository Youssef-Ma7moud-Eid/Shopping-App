import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/domain/entity/register_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';
import 'package:shopping_app/feature/auth/domain/usecase/register-usecase.dart';
import 'package:shopping_app/feature/auth/presentation/manager/register-cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repository) : super(InitialState());
  final RegisterUseCase _repository;
  Future<void> register(String name, String email, String pass) async {
    emit(LoadingRegister());
    var result = await _repository.call(
      RegisterParams(name: name, email: email, password: pass),
    );
    switch (result) {
      case NetworkSuccess<RegisterResponseEntity>():
        emit(SuccessRegister());
      case NetworkFailure<RegisterResponseEntity>():
        emit(FauilreRegister());
    }
  }
}

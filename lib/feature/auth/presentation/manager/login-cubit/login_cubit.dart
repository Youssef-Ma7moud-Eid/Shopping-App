import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper.dart';
import 'package:shopping_app/core/cache_helper/cashe_helper_keys.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/domain/entity/login_resonse_entity.dart';
import 'package:shopping_app/feature/auth/domain/usecase/auth_params.dart';
import 'package:shopping_app/feature/auth/domain/usecase/login-usecase.dart';
import 'package:shopping_app/feature/auth/presentation/manager/login-cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(InitialState());
  final LoginUseCase _loginUseCase;
  Future<void> login(String email, String pass) async {
    emit(LoadingLogin());
    var result = await _loginUseCase.call(
      LoginParams(email: email, password: pass),
    );
    switch (result) {
      case NetworkSuccess<LoginResonseEntity>():
        CacheHelper().saveData(
          key: CasheKeys.token,
          value: result.data.accessToken,
        );
        emit(SuccessLogin());
      case NetworkFailure<LoginResonseEntity>():
        emit(FauilreLogin());
    }
  }
}

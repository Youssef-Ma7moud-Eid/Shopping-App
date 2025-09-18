sealed class LoginState {}
class InitialState extends LoginState{}
class SuccessLogin extends LoginState{}
class LoadingLogin extends LoginState{}
class FauilreLogin extends LoginState{}
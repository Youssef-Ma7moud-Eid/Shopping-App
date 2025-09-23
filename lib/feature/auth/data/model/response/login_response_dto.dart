import 'package:shopping_app/feature/auth/domain/entity/login_resonse_entity.dart';

class LoginResponseDto {
  String? accessToken;
  String? refreshToken;

  LoginResponseDto({this.accessToken, this.refreshToken});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
  LoginResonseEntity toEntity() {
    return LoginResonseEntity(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
    );
  }
}

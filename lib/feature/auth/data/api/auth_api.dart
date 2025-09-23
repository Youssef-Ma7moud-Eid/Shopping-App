import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/model/request/login_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/login_response_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';
import 'package:shopping_app/feature/profile/data/model/profile_model.dart';

class AuthApi {
  AuthApi._();
  static AuthApi? _instance;
  static AuthApi get instance => _instance ??= AuthApi._();

  // https://api.escuelajs.co/api/v1/users/
  Future<NetworkResult<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async {
    try {
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/users/");

      var response = await https.post(url, body: request.toJson());
      var responseBody = response.body;
      var data = jsonDecode(responseBody);
      return NetworkSuccess(RegisterResponseDto.fromJson(data));
    } catch (e) {
      return NetworkFailure(e.toString());
    }
  }

  Future<NetworkResult<LoginResponseDto>> login(LoginRequestDto request) async {
    try {
      // https://api.escuelajs.co/api/v1/auth/login
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/auth/login");

      var response = await https.post(url, body: request.toJson());
      if (response.statusCode == 201) {
        var responseBody = response.body;
        var data = jsonDecode(responseBody);

        return NetworkSuccess(LoginResponseDto.fromJson(data));
      } else {
        var errorData = jsonDecode(response.body);
        return NetworkFailure(errorData["message"] ?? "Login failed");
      }
    } catch (e) {
      return NetworkFailure(e.toString());
    }
  }
  Future<NetworkResult<ProfileModel>> getProfile(String token) async {
  try {
    Uri url = Uri.https("api.escuelajs.co", "/api/v1/auth/profile");

    var response = await https.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return NetworkSuccess(ProfileModel.fromJson(data));
    } else {
      var errorData = jsonDecode(response.body);
      return NetworkFailure(errorData["message"] ?? "Failed to load profile");
    }
  } catch (e) {
    return NetworkFailure(e.toString());
  }
}

}

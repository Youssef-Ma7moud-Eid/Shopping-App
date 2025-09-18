import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/auth/data/model/request/reqister_request_dto.dart';
import 'package:shopping_app/feature/auth/data/model/response/register_response_dto.dart';

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
}

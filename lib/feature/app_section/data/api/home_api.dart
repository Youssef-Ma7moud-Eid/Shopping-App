import 'dart:convert';

import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/app_section/data/model/response/category_response_dto.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  HomeApi._();
  static HomeApi? _instance;
  static HomeApi get instance => _instance ??= HomeApi._();

  Future<NetworkResult<List<GetCategoryResponseDto>>> getCategories() async {
    // https://api.escuelajs.co/api/v1/categories/
    try {
      Uri url = Uri.parse("https://api.escuelajs.co/api/v1/categories/");
      var response = await http.get(url);
      var responseBody = response.body;
      List<dynamic> json = jsonDecode(responseBody);
      var data = json.map((e) => GetCategoryResponseDto.fromJson(e)).toList();
      return NetworkSuccess(data);
    } catch (e) {
      return NetworkFailure(e.toString());
    }
  }
}

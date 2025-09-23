import 'dart:convert';
import 'dart:developer';

import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/feature/home/data/model/response/product_model_dto.dart';

class HomeApi {
  HomeApi._();
  static HomeApi? _instance;
  static HomeApi get instance => _instance ??= HomeApi._();

  Future<NetworkResult<List<GetCategoryResponseDto>>> getCategories() async {
    // https://api.escuelajs.co/api/v1/categories/
    try {
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/categories/");
      var response = await http.get(url);
      var responseBody = response.body;
      List<dynamic> json = jsonDecode(responseBody);
      var data = json.map((e) => GetCategoryResponseDto.fromJson(e)).toList();
      return NetworkSuccess(data);
    } catch (e) {
      return NetworkFailure(e.toString());
    }
  }

  Future<NetworkResult<List<GetProductModelDto>>> getProducts() async {
    // https://api.escuelajs.co/api/v1/products/
    try {
      Uri url = Uri.https("api.escuelajs.co", "/api/v1/products/");
      var response = await http.get(url);
      var responseBody = response.body;
      List<dynamic> json = jsonDecode(responseBody);
      var data = json.map((e) => GetProductModelDto.fromJson(e)).toList();
      return NetworkSuccess(data);
    } catch (e) {
      return NetworkFailure(e.toString());
    }
  }

  Future<NetworkResult<List<GetProductModelDto>>> getProductsByCategory(
    int id,
  ) async {
    // https://api.escuelajs.co/api/v1/categories/1/products
    try {
      Uri url = Uri.https(
        "api.escuelajs.co",
        "/api/v1/categories/$id/products",
      );
      var response = await http.get(url);
      var responseBody = response.body;
      List<dynamic> json = jsonDecode(responseBody);
      var data = json.map((e) => GetProductModelDto.fromJson(e)).toList();
      log(id.toString());
      log(data.length.toString());
      log(data.toString());
      return NetworkSuccess(data);
    } catch (e) {
      log(id.toString());
      log("id");
      return NetworkFailure(e.toString());
    }
  }
}

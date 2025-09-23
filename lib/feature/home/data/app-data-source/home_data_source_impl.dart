import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/data/api/home_api.dart';
import 'package:shopping_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:shopping_app/feature/home/data/model/response/product_model_dto.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/domain/repo/datasource/home_data_source_contract.dart';

class HomeDataSourceImpl implements HomeDataSourceContract {
  const HomeDataSourceImpl(this._api);
  final HomeApi _api;

  @override
  Future<NetworkResult<List<GetCategoryEntity>>> getAllCategories() async {
    final result = await _api.getCategories();
    switch (result) {
      case NetworkSuccess<List<GetCategoryResponseDto>>():
        return NetworkSuccess<List<GetCategoryEntity>>(
          result.data.map((e) => e.toEntity()).toList(),
        );
      case NetworkFailure<List<GetCategoryResponseDto>>():
        return NetworkFailure<List<GetCategoryEntity>>(result.errorMessage);
    }
  }

  @override
  Future<NetworkResult<List<GetProductEntity>>> getAllProducts() async {
    final result = await _api.getProducts();
    switch (result) {
      case NetworkSuccess<List<GetProductModelDto>>():
        return NetworkSuccess<List<GetProductEntity>>(
          result.data.map((e) => e.toEntity()).toList(),
        );
      case NetworkFailure<List<GetProductModelDto>>():
        return NetworkFailure<List<GetProductEntity>>(result.errorMessage);
    }
  }

  @override
  Future<NetworkResult<List<GetProductEntity>>> getProductsByCategory(
    int id,
  ) async {
    final result = await _api.getProductsByCategory(id);
    switch (result) {
      case NetworkSuccess<List<GetProductModelDto>>():
        return NetworkSuccess<List<GetProductEntity>>(
          result.data.map((e) => e.toEntity()).toList(),
        );
      case NetworkFailure<List<GetProductModelDto>>():
        return NetworkFailure<List<GetProductEntity>>(result.errorMessage);
    }
  }
}

HomeDataSourceContract injectHomeDataSource() =>
    HomeDataSourceImpl(HomeApi.instance);

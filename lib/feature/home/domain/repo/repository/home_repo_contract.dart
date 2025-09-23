import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';

abstract class HomeRepoContract {
  Future<NetworkResult<List<GetCategoryEntity>>> getCategories();
  Future<NetworkResult<List<GetProductEntity>>> getProducts();
  Future<NetworkResult<List<GetProductEntity>>> getProductsByCategory(int id);
}

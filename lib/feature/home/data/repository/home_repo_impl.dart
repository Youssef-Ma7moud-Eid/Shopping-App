import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/data/app-data-source/home_data_source_impl.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/domain/repo/datasource/home_data_source_contract.dart';
import 'package:shopping_app/feature/home/domain/repo/repository/home_repo_contract.dart';

class HomeRepoImpl implements HomeRepoContract {
  const HomeRepoImpl(this._dataSource);
  final HomeDataSourceContract _dataSource;

  @override
  Future<NetworkResult<List<GetCategoryEntity>>> getCategories() {
    return _dataSource.getAllCategories();
  }

  @override
  Future<NetworkResult<List<GetProductEntity>>> getProducts() {
    return _dataSource.getAllProducts();
  }

  @override
  Future<NetworkResult<List<GetProductEntity>>> getProductsByCategory(int id) {
    return _dataSource.getProductsByCategory(id);
  }
}

HomeRepoContract injectHomeRepo() => HomeRepoImpl(injectHomeDataSource());

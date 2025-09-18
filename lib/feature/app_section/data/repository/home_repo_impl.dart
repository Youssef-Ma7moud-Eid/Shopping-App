import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/app_section/data/app-data-source/home_data_source_contract.dart';
import 'package:shopping_app/feature/app_section/data/app-data-source/home_data_source_impl.dart';
import 'package:shopping_app/feature/app_section/data/model/response/category_response_dto.dart';
import 'package:shopping_app/feature/app_section/data/repository/home_repo_contract.dart';

class HomeRepoImpl implements HomeRepoContract {
  const HomeRepoImpl(this._dataSource);
  final HomeDataSourceContract _dataSource;

  @override
  Future<NetworkResult<List<GetCategoryResponseDto>>> getCategories() async =>
      await _dataSource.getAllCategories();
}

HomeRepoContract injectHomeRepo() => HomeRepoImpl(injectHomeDataSource());

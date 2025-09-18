import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/app_section/data/api/home_api.dart';
import 'package:shopping_app/feature/app_section/data/app-data-source/home_data_source_contract.dart';
import 'package:shopping_app/feature/app_section/data/model/response/category_response_dto.dart';

class HomeDataSourceImpl implements HomeDataSourceContract {
  const HomeDataSourceImpl(this._api);
  final HomeApi _api;
  @override
  Future<NetworkResult<List<GetCategoryResponseDto>>>
  getAllCategories() async => await _api.getCategories();
}
HomeDataSourceContract injectHomeDataSource() => HomeDataSourceImpl(HomeApi.instance);
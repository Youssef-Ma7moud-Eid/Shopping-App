import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/app_section/data/model/response/category_response_dto.dart';

abstract class HomeRepoContract {
  Future<NetworkResult<List<GetCategoryResponseDto>>> getCategories();
}
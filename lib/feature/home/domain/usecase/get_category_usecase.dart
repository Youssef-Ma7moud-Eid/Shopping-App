import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/data/repository/home_repo_impl.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';
import 'package:shopping_app/feature/home/domain/repo/repository/home_repo_contract.dart';

class GetCategoryUsecase {
  GetCategoryUsecase(this.homeRepoContract);
  final HomeRepoContract homeRepoContract;
  Future<NetworkResult<List<GetCategoryEntity>>> call() {
    return homeRepoContract.getCategories();
  }
}

GetCategoryUsecase injectableGetCategoryUsecase() =>
    GetCategoryUsecase(injectHomeRepo());

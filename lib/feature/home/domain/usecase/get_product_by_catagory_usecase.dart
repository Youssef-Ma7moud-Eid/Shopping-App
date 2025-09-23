import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/data/repository/home_repo_impl.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/domain/repo/repository/home_repo_contract.dart';

class GetProductByCatagoryUsecase {
  GetProductByCatagoryUsecase(this.homeRepoContract);
  final HomeRepoContract homeRepoContract;
  Future<NetworkResult<List<GetProductEntity>>> call(int id) {
    return homeRepoContract.getProductsByCategory(id);
  }
}

GetProductByCatagoryUsecase injectableGetProductByCatagoryUsecase() =>
    GetProductByCatagoryUsecase(injectHomeRepo());

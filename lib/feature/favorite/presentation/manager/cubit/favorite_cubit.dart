import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/main.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  void getFavoriteProducts() {
    if (MyApp.listFavorite.isEmpty) {
      emit(FavoriteListEmpty());
    } else {
      emit(FavoriteListSuccess());
    }
  }

  bool? addToFavorite(GetProductEntity product) {
    final exists = MyApp.listFavorite.any((p) => p.id == product.id);
    if (!exists) {
      MyApp.listFavorite.add(product);

      product.icon = Icons.favorite;
      emit(FavoriteListSuccess());
      return null;
    } else {
      return false;
    }
  }

  void deleteProductFromFavorite(GetProductEntity product) {
    MyApp.listFavorite.removeWhere((p) => p.id == product.id);
    product.icon = Icons.favorite_border;
    emit(FavoriteListSuccess());

    if (MyApp.listFavorite.isEmpty) emit(FavoriteListEmpty());
  }
}

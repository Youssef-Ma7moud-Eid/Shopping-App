import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';

part 'add_cart_state.dart';

class AddCartCubit extends Cubit<AddCartCubitState> {
  AddCartCubit() : super(AddCartCubitInitial());

  static List<GetProductEntity> list = [];
  static ValueNotifier<double> totalAmoun = ValueNotifier(0);
  void getProductsCart() {
    if (list.isEmpty) {
      emit(AddCartCubitEmpty());
    } else {
      emit(AddCartCubitList());
    }
  }

  bool? addProductToCart(GetProductEntity product) {
    final exists = list.any((p) => p.id == product.id);
    if (!exists) {
      list.add(product);
      totalAmoun.value += product.price ?? 0;
      return null;
    } else {
      return false;
    }
  }

  void deleteProductFromCart(int id, double amount) {
    list.removeWhere((p) => p.id == id);
    totalAmoun.value -= amount;

    if (list.isEmpty) emit(AddCartCubitEmpty());
  }
}

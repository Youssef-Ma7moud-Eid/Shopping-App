// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:flutter/material.dart';

import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/domain/usecase/get_products_usecase.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit(this._getProductsUsecase) : super(GetProductsInitial());
  final GetProductsUsecase _getProductsUsecase;

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final result = await _getProductsUsecase.call();
    switch (result) {
      case NetworkSuccess<List<GetProductEntity>>():
        emit(GetProductsSuccess(result.data));
      case NetworkFailure<List<GetProductEntity>>():
        emit(GetProductsFauilre(result.errorMessage));
    }
  }
}

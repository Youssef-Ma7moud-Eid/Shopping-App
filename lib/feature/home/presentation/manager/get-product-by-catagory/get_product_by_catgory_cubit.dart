import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:flutter/material.dart';

import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';

import 'package:shopping_app/feature/home/domain/usecase/get_product_by_catagory_usecase.dart';

part 'get_product_by_catgory_state.dart';

class GetProductByCatgoryCubit extends Cubit<GetProductByCatgoryState> {
  GetProductByCatgoryCubit(this._categoryUsecase)
    : super(GetProductByCatgoryInitial());
  final GetProductByCatagoryUsecase _categoryUsecase;
  Future<void> getProductsByCategory(int id) async {
    emit(GetProductByCatgoryLoading());
    final result = await _categoryUsecase.call(id);
    switch (result) {
      case NetworkSuccess<List<GetProductEntity>>():
        log("sucessssssss");
        emit(GetProductByCatgorySuccess(result.data));
      case NetworkFailure<List<GetProductEntity>>():
        log("fauilreeee");

        emit(GetProductByCatgoryFauilre(result.errorMessage));
    }
  }
}

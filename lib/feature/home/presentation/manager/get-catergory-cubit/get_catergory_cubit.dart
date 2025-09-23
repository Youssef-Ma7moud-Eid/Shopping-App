import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/network/network.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';
import 'package:shopping_app/feature/home/domain/usecase/get_category_usecase.dart';

part 'get_catergory_state.dart';

class GetCatergoryCubit extends Cubit<GetCatergoryState> {
  GetCatergoryCubit(this._categoryUsecase) : super(GetCatergoryInitial());
  final GetCategoryUsecase _categoryUsecase;

  Future<void> getCategories() async {
    emit(GetCatergoryLoading());
    final result = await _categoryUsecase.call();
    switch (result) {
      case NetworkSuccess<List<GetCategoryEntity>>():
        emit(GetCatergorySuccess(result.data));
      case NetworkFailure<List<GetCategoryEntity>>():
        emit(GetCatergoryFauilre(result.errorMessage));
    }
  }
}

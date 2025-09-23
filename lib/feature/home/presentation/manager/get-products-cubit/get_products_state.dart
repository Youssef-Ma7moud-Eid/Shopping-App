part of 'get_products_cubit.dart';

@immutable
sealed class GetProductsState {
  const GetProductsState();
}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsSuccess extends GetProductsState {
  final List<GetProductEntity> products;
  const GetProductsSuccess(this.products);
}

class GetProductsFauilre extends GetProductsState {
  final String errorMessage;
  const GetProductsFauilre(this.errorMessage);
}

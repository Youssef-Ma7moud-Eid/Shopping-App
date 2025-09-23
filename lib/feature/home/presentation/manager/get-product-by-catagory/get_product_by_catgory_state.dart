part of 'get_product_by_catgory_cubit.dart';

@immutable
sealed class GetProductByCatgoryState {
  const GetProductByCatgoryState();
}

class GetProductByCatgoryInitial extends GetProductByCatgoryState {}

class GetProductByCatgoryLoading extends GetProductByCatgoryState {}

class GetProductByCatgorySuccess extends GetProductByCatgoryState {
  final List<GetProductEntity> products;
  const GetProductByCatgorySuccess(this.products);
}

class GetProductByCatgoryFauilre extends GetProductByCatgoryState {
  final String errorMessage;
  const GetProductByCatgoryFauilre(this.errorMessage);
}

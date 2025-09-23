part of 'get_catergory_cubit.dart';

@immutable
sealed class GetCatergoryState {
  const GetCatergoryState();
}

class GetCatergoryInitial extends GetCatergoryState {}

class GetCatergoryLoading extends GetCatergoryState {}

class GetCatergorySuccess extends GetCatergoryState {
  final List<GetCategoryEntity> categories;
  const GetCatergorySuccess(this.categories);
}

class GetCatergoryFauilre extends GetCatergoryState {
  final String errorMessage;
  const GetCatergoryFauilre(this.errorMessage);
}

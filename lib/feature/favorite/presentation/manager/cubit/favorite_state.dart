part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}


class FavoriteInitial extends FavoriteState {}

class FavoriteListSuccess extends FavoriteState {}

class FavoriteListEmpty extends FavoriteState {}


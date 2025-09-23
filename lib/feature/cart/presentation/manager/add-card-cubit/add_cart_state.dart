part of 'add_cart_cubit.dart';

@immutable
sealed class AddCartCubitState {}

class AddCartCubitInitial extends AddCartCubitState {}

class AddCartCubitList extends AddCartCubitState {}

class AddCartCubitEmpty extends AddCartCubitState {}

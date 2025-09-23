import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/cart/presentation/manager/add-card-cubit/add_cart_cubit.dart';
import 'package:shopping_app/feature/cart/presentation/widgets/card_body_widget.dart';
import 'package:shopping_app/feature/cart/presentation/widgets/check_out_section.dart';
import 'package:shopping_app/feature/cart/presentation/widgets/empty_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<AddCartCubit>(context).getProductsCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffF8F8F8),
        elevation: 0,
      ),
      body: BlocBuilder<AddCartCubit, AddCartCubitState>(
        builder: (context, state) {
          if (state is AddCartCubitList) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CartBodyWidget(products: AddCartCubit.list),
            );
          } else {
            return EmptyScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<AddCartCubit, AddCartCubitState>(
        builder: (context, state) {
          if (state is AddCartCubitList) {
            return const CheckOutSection();
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

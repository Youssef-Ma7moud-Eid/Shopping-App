import 'package:flutter/material.dart';
import 'package:shopping_app/feature/cart/presentation/widgets/cart_item.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';

class CartBodyWidget extends StatelessWidget {
  const CartBodyWidget({super.key, required this.products});
  final List<GetProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        return CardItem(product: products[index]);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/presentation/widgets/product_item.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key, required this.product});
  final GetProductEntity product;

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [ProductItem(product: widget.product)],
      ),
    );
  }
}

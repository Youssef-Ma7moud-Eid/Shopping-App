import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/presentation/widgets/product_view_body.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.product, required this.id});
  static String routeName = '/ProductViewBody';
  final GetProductEntity product;
  final int id;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(backgroundColor: Color(0xffEBEBEB)),
      body: ProductViewBody(product: product, id: id),
    );
  }
}

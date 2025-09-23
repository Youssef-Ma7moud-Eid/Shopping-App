import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/presentation/widgets/product_of_category_body.dart';

class ProuctOfCategoryView extends StatelessWidget {
  const ProuctOfCategoryView({super.key, required this.id});
  static String routeName = "/ProuctOfCategoryView";
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xffEBEBEB),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ProductOfCategoryBody(id:id),
    );
  }
}

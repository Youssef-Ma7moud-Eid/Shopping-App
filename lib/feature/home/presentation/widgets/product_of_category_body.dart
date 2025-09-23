import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/home/data/model/response/product_model_dto.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-product-by-catagory/get_product_by_catgory_cubit.dart';
import 'package:shopping_app/feature/home/presentation/view/product_view.dart';
import 'package:shopping_app/feature/home/presentation/widgets/product_item.dart';
import 'package:shopping_app/feature/home/presentation/widgets/search_helper.dart';
import 'package:shopping_app/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductOfCategoryBody extends StatefulWidget {
  const ProductOfCategoryBody({super.key, required this.id});
  final int id;

  @override
  State<ProductOfCategoryBody> createState() => _ProductOfCategoryBodyState();
}

class _ProductOfCategoryBodyState extends State<ProductOfCategoryBody> {
  List<GetProductEntity> allProducts = [];
  List<GetProductEntity> filteredProducts = [];

  void _filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = allProducts;
      });
    } else {
      setState(() {
        filteredProducts = allProducts
            .where(
              (product) =>
                  product.title!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          TextFormFieldHelper(
            isMobile: true,
            onChanged: (value) => _filterProducts(value ?? ''),
            borderRadius: BorderRadius.circular(12),
            hint: "Search for your products",
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xff000000),
              size: 30,
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<GetProductByCatgoryCubit, GetProductByCatgoryState>(
            builder: (context, state) {
              if (state is GetProductByCatgoryLoading) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 30,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      return Skeletonizer(
                        enabled: true,
                        child: ProductItem(product: productsDumy),
                      );
                    },
                  ),
                );
              } else if (state is GetProductByCatgorySuccess) {
                if (allProducts.isEmpty) {
                  allProducts = state.products;
                  filteredProducts = state.products;
                }

                return Expanded(
                  child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final exists = MyApp.listFavorite.any(
                        (p) => p.id == product.id,
                      );
                      if (exists) {
                        product.icon = Icons.favorite;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductView(
                                  product: product,
                                  id: widget.id,
                                ),
                              ),
                            );
                          },
                          child: ProductItem(product: product, id: widget.id),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is GetProductByCatgoryFauilre) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            },
          ),
        ],
      ),
    );
  }
}

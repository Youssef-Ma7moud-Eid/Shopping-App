import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/widgets/empty_favourite_list.dart';
import 'package:shopping_app/feature/favorite/presentation/widgets/favorite_item.dart';
import 'package:shopping_app/feature/home/presentation/view/product_view.dart';
import 'package:shopping_app/main.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffF8F8F8),

        title: const Text(
          "My Favourite",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteListSuccess) {
            var products = MyApp.listFavorite;
            return Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductView(product: products[index], id: 1),
                          ),
                        );
                      },
                      child: FavoriteItem(product: products[index]),
                    ),
                  );
                },
              ),
            );
          } else {
            return EmptyFavouriteList();
          }
        },
      ),
    );
  }
}


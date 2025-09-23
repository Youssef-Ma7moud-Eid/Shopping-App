import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:shopping_app/feature/home/data/model/response/product_model_dto.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-catergory-cubit/get_catergory_cubit.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-products-cubit/get_products_cubit.dart';
import 'package:shopping_app/feature/home/presentation/view/product_view.dart';
import 'package:shopping_app/feature/home/presentation/widgets/product_item.dart';
import 'package:shopping_app/feature/home/presentation/widgets/tab_container_widget.dart';
import 'package:shopping_app/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: 'Hi !,\n',
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'Let’s start your shopping',
                  style: TextStyle(
                    color: Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15),
          BlocBuilder<GetCatergoryCubit, GetCatergoryState>(
            builder: (context, state) {
              if (state is GetCatergoryLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: TabContainerWidget(categories: categoriesDumy),
                );
              } else if (state is GetCatergorySuccess) {
                return TabContainerWidget(categories: state.categories);
              } else if (state is GetCatergoryFauilre) {
                return Center(child: Text(state.errorMessage));
              } else {
                return Center(child: Text("Something went wrong"));
              }
            },
          ),
          SizedBox(height: 16),
          BlocBuilder<GetProductsCubit, GetProductsState>(
            builder: (context, state) {
              if (state is GetProductsLoading) {
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
              } else if (state is GetProductsSuccess) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final exists = MyApp.listFavorite.any(
                        (p) => p.id == state.products[index].id,
                      );
                      if (exists) {
                        state.products[index].icon = Icons.favorite;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductView(
                                  product: state.products[index],
                                  id: 1,
                                ),
                              ),
                            );
                          },
                          child: ProductItem(
                            product: state.products[index],
                            isHome: true,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is GetProductsFauilre) {
                return Center(child: Text(state.errorMessage));
              } else {
                return Center(child: Text("Something went wrong"));
              }
            },
          ),
        ],
      ),
    );
  }
}


String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';


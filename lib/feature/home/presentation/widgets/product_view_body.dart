import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopping_app/core/dialogs/app_toasts.dart';
import 'package:shopping_app/core/widgets/custom_button.dart';
import 'package:shopping_app/feature/cart/presentation/manager/add-card-cubit/add_cart_cubit.dart';
import 'package:shopping_app/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-product-by-catagory/get_product_by_catgory_cubit.dart';
import 'package:shopping_app/feature/home/presentation/manager/get-products-cubit/get_products_cubit.dart';
import 'package:shopping_app/feature/home/presentation/view/home_screen.dart';
import 'package:shopping_app/feature/home/presentation/widgets/build_circle_icon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toastification/toastification.dart';

class ProductViewBody extends StatefulWidget {
  const ProductViewBody({super.key, required this.product, required this.id});
  final GetProductEntity product;
  final int id;
  @override
  State<ProductViewBody> createState() => _ProductViewBodyState();
}

class _ProductViewBodyState extends State<ProductViewBody> {
  late PageController controller;
  int index = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images =
        widget.product.images ?? [dummyImage, dummyImage, dummyImage];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.38,
            child: PageView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => index = value),
              itemCount: images.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: images[i],
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (widget.product.icon ==
                                      Icons.favorite_border) {
                                    BlocProvider.of<FavoriteCubit>(
                                      context,
                                    ).addToFavorite(widget.product);
                                  } else {
                                    BlocProvider.of<FavoriteCubit>(
                                      context,
                                    ).deleteProductFromFavorite(widget.product);
                                  }
                                  BlocProvider.of<GetProductsCubit>(
                                    context,
                                  ).getProducts();
                                  BlocProvider.of<GetProductByCatgoryCubit>(
                                    context,
                                  ).getProductsByCategory(widget.id);
                                  setState(() {});
                                },
                                child: buildCircleIcon(
                                  widget.product.icon,
                                  Colors.red,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  final url =
                                      widget.product.images?[index] ??
                                      dummyImage;
                                  Share.share(
                                    url,
                                    subject:
                                        widget.product.title ??
                                        "Check this out!",
                                  );
                                },
                                child: buildCircleIcon(
                                  Icons.share,
                                  Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: images.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                spacing: 6,
                dotColor: Colors.grey.shade400,
                activeDotColor: Theme.of(context).primaryColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            widget.product.title ?? 'Shopping',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 8),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'EGP ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                TextSpan(
                  text: (widget.product.price ?? 100).toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            widget.product.description ??
                'No description available for this product.',
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),

          const Spacer(),

          CustomButton(
            title: "Add to Cart 🛒",
            onPressed: () {
              bool? isAdded = BlocProvider.of<AddCartCubit>(
                context,
              ).addProductToCart(widget.product);
              AppToast.showToast(
                context: context,
                title: isAdded == null ? "Success Add to Cart" : 'Warning',
                description: isAdded == null
                    ? "Operation Success"
                    : "Aready Added Before",
                type: isAdded == null
                    ? ToastificationType.success
                    : ToastificationType.warning,
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

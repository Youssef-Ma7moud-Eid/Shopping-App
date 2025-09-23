import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/feature/cart/presentation/manager/add-card-cubit/add_cart_cubit.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/presentation/view/home_screen.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.product});
  final GetProductEntity product;
  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  double amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: widget.product.images?.first ?? dummyImage,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title ?? 'No title',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff212121),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'EGP ${(widget.product.price?.toStringAsFixed(2) ?? '')}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (amount > 1) {
                          setState(() {
                            amount--;
                            AddCartCubit.totalAmoun.value -=
                                (widget.product.price ?? 0);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      amount.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          amount++;
                          AddCartCubit.totalAmoun.value +=
                              (widget.product.price ?? 0);
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<AddCartCubit>(context).deleteProductFromCart(
                widget.product.id!,
                amount * widget.product.price! ,
              );
            },
            icon: const Icon(Icons.cancel_outlined, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}

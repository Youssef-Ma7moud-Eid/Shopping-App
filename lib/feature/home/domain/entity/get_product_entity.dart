import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';

class GetProductEntity {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final GetCategoryEntity? category;
  final List<String> images;
   IconData icon = Icons.favorite_border;

   GetProductEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
    required this.icon,
  });
}

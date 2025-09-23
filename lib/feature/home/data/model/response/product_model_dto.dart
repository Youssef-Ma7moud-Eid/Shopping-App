import 'package:flutter/material.dart';
import 'package:shopping_app/feature/home/data/model/response/category_response_dto.dart';
import 'package:shopping_app/feature/home/domain/entity/get_product_entity.dart';
import 'package:shopping_app/feature/home/presentation/view/home_screen.dart';

class GetProductModelDto {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  GetCategoryResponseDto? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;
  IconData icon = Icons.favorite_border;

  GetProductModelDto({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
    this.creationAt,
    this.updatedAt,
  });

  GetProductModelDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? GetCategoryResponseDto.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
  GetProductEntity toEntity() {
    return GetProductEntity(
      id: id ?? 0,
      title: title ?? '',
      slug: slug ?? '',
      price: price ?? 0,
      description: description ?? '',
      category: category?.toEntity(),
      images: images ?? [],
      icon: Icons.favorite_border,
    );
  }
}
GetProductEntity productsDumy = GetProductEntity(
  id: 4,
  title: "Product 4",
  slug: "product-4",
  price: 400,
  description: "This is product 4",
  images: [dummyImage],
  category: null,
  icon: Icons.favorite_border,
);
import 'package:shopping_app/feature/home/domain/entity/get_category_entity.dart';

class GetCategoryResponseDto {
  int? id;
  String? name;
  String? slug;
  String? image;

  GetCategoryResponseDto({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  GetCategoryResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  GetCategoryEntity toEntity() {
    return GetCategoryEntity(
      id: id ?? 0,
      name: name ?? '',
      slug: slug ?? '',
      image: image ?? '',
    );
  }
}
List<GetCategoryEntity> categoriesDumy = [
  GetCategoryEntity(id: 1, name: "All", slug: '', image: ''),
  GetCategoryEntity(id: 2, name: "Electronics", slug: '', image: ''),
  GetCategoryEntity(id: 3, name: "Jewelery", slug: '', image: ''),
  GetCategoryEntity(id: 1, name: "All", slug: '', image: ''),
  GetCategoryEntity(id: 2, name: "Electronics", slug: '', image: ''),
  GetCategoryEntity(id: 3, name: "Jewelery", slug: '', image: ''),
];

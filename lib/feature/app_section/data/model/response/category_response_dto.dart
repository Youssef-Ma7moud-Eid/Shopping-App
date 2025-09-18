class GetCategoryResponseDto {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? creationAt;
  String? updatedAt;

  GetCategoryResponseDto(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.creationAt,
      this.updatedAt});

  GetCategoryResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

 
}
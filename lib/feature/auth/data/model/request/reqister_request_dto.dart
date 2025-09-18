class RegisterRequestDto {
  const RegisterRequestDto({
    this.name,
    this.email,
    this.password,
    this.avatar = "https://picsum.photos/800",
  });

  final String? name;
  final String? email;
  final String? password;
  final String? avatar;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = avatar;
    return data;
  }
}

class LoginRequestDto {
  final String? email;
  final String? password;

  const LoginRequestDto({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class UserModel {
  final String name;
  final String phone;
  final String email;
  final String password;
  String? image;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
    };
  }
}

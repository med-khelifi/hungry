class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? token;
  final String? viza;
  final String? address;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.token,
    this.viza,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      image: json['image'] ?? "",
      token: json['token'] ?? "",
      viza: json['Visa'] ?? "",
      address: json['address'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'token': token,
      'Visa': viza,
      'address': address,
    };
  }
}

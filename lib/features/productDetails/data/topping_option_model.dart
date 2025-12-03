class ToppingOptionModel {
  final int id;
  final String name;
  final String imagePath;

  ToppingOptionModel({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  factory ToppingOptionModel.fromJson(Map<String, dynamic> json) {
    return ToppingOptionModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imagePath: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imagePath,
    };
  }
}
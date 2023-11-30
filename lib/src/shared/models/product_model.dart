class ProductModel {
  final String description;
  final String linkPhoto;
  final String barCode;
  final String validate;

  ProductModel({
    required this.description,
    this.linkPhoto = '',
    required this.barCode,
    required this.validate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      description: json['description'].toString(),
      barCode: json['barCode'].toString(),
      validate: json['validate'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'barCode': barCode,
      'linkPhoto': linkPhoto,
      'validate': validate,
    };
  }
}

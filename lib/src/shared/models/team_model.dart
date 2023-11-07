import 'package:promotor_app/src/shared/models/product_model.dart';

class TeamModel {
  final String admin;
  final String title;
  final List<ProductModel> listProducts;

  TeamModel({
    required this.admin,
    required this.title,
    required this.listProducts,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    var productsJson = json['listProducts'] as List<dynamic>;
    List<ProductModel> products = productsJson
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();

    return TeamModel(
      admin: json['admin'].toString(),
      title: json['title'].toString(),
      listProducts: products,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJsonList =
        listProducts.map((product) => product.toJson()).toList();

    return {
      'admin': admin,
      'title': title,
      'listProducts': productsJsonList,
    };
  }
}

import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';

class TeamModel {
  final String admin;
  final String title;
  final List<ProductModel> listProducts;
  final List<UserModel> listUsers;

  TeamModel({
    required this.admin,
    required this.title,
    required this.listProducts,
    required this.listUsers,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    var productsJson = json['listProducts'] as List<dynamic>;
    var usersJson = json['listUsers'] as List<dynamic>;
    List<ProductModel> products = productsJson
        .map((productJson) => ProductModel.fromJson(productJson))
        .toList();
    List<UserModel> users =
        usersJson.map((usersJson) => UserModel.fromJson(usersJson)).toList();

    return TeamModel(
      admin: json['admin'].toString(),
      title: json['title'].toString(),
      listProducts: products,
      listUsers: users,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJsonList =
        listProducts.map((product) => product.toJson()).toList();

    List<Map<String, dynamic>> usersJsonList =
        listUsers.map((user) => user.toJson()).toList();

    return {
      'admin': admin,
      'title': title,
      'listProducts': productsJsonList,
      'listUsers': usersJsonList,
    };
  }
}

import 'package:image_picker/image_picker.dart';
import 'package:promotor_app/src/features/products/services/product_service.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class ProductRepository {
  final FirebaseService _firebaseService;
  final ProductService _productService;
  late UserModel myUser;
  late TeamModel myTeam;

  ProductRepository(this._firebaseService, this._productService) {
    getUserCurrent();
  }

  Future<void> getUserCurrent() async {
    myUser = (await _firebaseService.userLogged())!;
  }

  Future<void> addProduct({required ProductModel productModel}) async {
    await _firebaseService.addProduct(productModel: productModel);
  }

  Future<void> editProduct({
    required ProductModel product,
    required int index,
  }) async {
    await _firebaseService.editProduct(
      product: product,
      index: index,
      idTeamCurrent: myUser.team,
    );
  }

  Future<String> readBarCode() async {
    return await _productService.readBarCode();
  }

  Future<String> getImage(ImageSource source) async {
    return await _productService.getImage(source);
  }

  Future<String> addImageStorage(
      {required path, required String identifier}) async {
    return await _firebaseService.addImageStorage(
        path: path, identifier: identifier, user: myUser);
  }

  Future<List<ProductModel>> getListProducts() async {
    return (await _firebaseService.getTeamCurrent()).listProducts;
  }
}

import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class ProductRepository {
  final FirebaseService _firebaseService;

  ProductRepository(this._firebaseService);

  Future<void> addProduct({required ProductModel productModel}) async {
    await _firebaseService.addProduct(productModel: productModel);
  }

  Future<void> editProduct({
    required ProductModel product,
    required int index,
  }) async {
    await _firebaseService.editProduct(product: product, index: index);
  }
}

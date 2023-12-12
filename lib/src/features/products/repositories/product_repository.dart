import 'package:image_picker/image_picker.dart';
import 'package:promotor_app/src/features/products/services/product_service.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class ProductRepository {
  final FirebaseService _firebaseService;
  final ProductService _productService;

  ProductRepository(this._firebaseService, this._productService);

  Future<void> addProduct({required ProductModel productModel}) async {
    await _firebaseService.addProduct(productModel: productModel);
  }

  Future<void> editProduct({
    required ProductModel product,
    required int index,
  }) async {
    await _firebaseService.editProduct(product: product, index: index);
  }

  Future<String> readBarCode() async {
    return await _productService.readBarCode();
  }

  Future<String> getImage(ImageSource source) async {
    return await _productService.getImage(source);
  }

  Future<void> addImageStorage(String path, String identifier) async {
    return await _firebaseService.addImageStorage(path, identifier);
  }
}

import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class HomeRepository {
  final FirebaseService _firebaseService;

  HomeRepository(this._firebaseService);

  Future<List<ProductModel>> getListProducts() async {
    return _firebaseService.getListProducts();
  }
}

import 'package:promotor_app/src/shared/models/product_model.dart';

abstract class FirebaseService {
  Future<void> initialize();

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  });

  Future<void> createTeam();

  Future<void> setTeam({required uidTeam});

  Future<void> addProduct({required ProductModel productModel});

  // Future<List<ProductModel>> getListProducts();
}

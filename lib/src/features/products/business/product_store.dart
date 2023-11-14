import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/products/business/product_state.dart';
import 'package:promotor_app/src/features/products/repositories/product_repository.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
part 'product_store.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  final ProductRepository _productRepository;

  @observable
  ProductState state = ProductInitState();

  ProductStoreBase(this._productRepository);

  Future<void> addProduct(ProductModel productModel) async {
    state = ProductLoadingState();
    await _productRepository.addProduct(productModel: productModel);
    state = ProductSucessState();
  }
}

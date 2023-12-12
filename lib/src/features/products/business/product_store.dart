import 'package:image_picker/image_picker.dart';
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

  @action
  Future<void> addProduct(ProductModel productModel) async {
    state = ProductLoadingState();
    await _productRepository.addProduct(productModel: productModel);
    state = ProductSucessState();
  }

  @action
  Future<void> editProduct({
    required ProductModel product,
    required int index,
  }) async {
    state = ProductLoadingState();
    await _productRepository.editProduct(product: product, index: index);
    state = ProductSucessState();
  }

  @action
  Future<String> readBarCode() async {
    return await _productRepository.readBarCode();
  }

  @action
  Future<String> getImage(ImageSource source) async {
    state = ProductLoadingState();
    final pickerImage = await _productRepository.getImage(source);
    state = ProductSucessState();
    return pickerImage;
  }

  @action
  Future<void> addImageStorage(String path, String identifier) async {
    state = ProductLoadingState();
    await _productRepository.addImageStorage(path, identifier);
    state = ProductSucessState();
  }

  // @action
  // Future<void> setImageProduct() async {
  //   state = ProductLoadingState();
  //   final path = await getImage(ImageSource.gallery);
  //   await addImageStorage(path);
  //   state = ProductState();
  // }
}

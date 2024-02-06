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

  @observable
  List<ProductModel> listProducts = [];

  ProductStoreBase(this._productRepository) {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    await getListProducts();
  }

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
  Future<String> getImage(
      {required ImageSource source, required String barCode}) async {
    state = ProductLoadingState();
    final localPathImage = await _productRepository.getImage(source);
    final storagePath = await _productRepository.addImageStorage(
        path: localPathImage, identifier: barCode);
    state = ProductSucessState();
    return storagePath;
  }

  @action
  Future<void> getListProducts() async {
    state = ProductLoadingState();
    listProducts = await _productRepository.getListProducts();
    state = ProductSucessState();
  }

  @action
  bool checkSingleBarCode({required String barCode}) {
    state = ProductLoadingState();
    int cont = 0;
    bool test = true;
    for (var element in listProducts) {
      if (element.barCode == barCode) {
        cont++;
      }
    }
    if (cont > 0) {
      test = false;
      state = ProductInitState();
    } else {
      state = ProductSucessState();
    }
    return test;
  }

  //TODO: Criar Função que verifica se já existe o Código de Barras na Lista
}

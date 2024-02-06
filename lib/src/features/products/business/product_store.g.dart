// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on ProductStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'ProductStoreBase.state', context: context);

  @override
  ProductState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProductState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$listProductsAtom =
      Atom(name: 'ProductStoreBase.listProducts', context: context);

  @override
  List<ProductModel> get listProducts {
    _$listProductsAtom.reportRead();
    return super.listProducts;
  }

  @override
  set listProducts(List<ProductModel> value) {
    _$listProductsAtom.reportWrite(value, super.listProducts, () {
      super.listProducts = value;
    });
  }

  late final _$_initializeAsyncAction =
      AsyncAction('ProductStoreBase._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  late final _$addProductAsyncAction =
      AsyncAction('ProductStoreBase.addProduct', context: context);

  @override
  Future<void> addProduct(ProductModel productModel) {
    return _$addProductAsyncAction.run(() => super.addProduct(productModel));
  }

  late final _$editProductAsyncAction =
      AsyncAction('ProductStoreBase.editProduct', context: context);

  @override
  Future<void> editProduct(
      {required ProductModel product, required int index}) {
    return _$editProductAsyncAction
        .run(() => super.editProduct(product: product, index: index));
  }

  late final _$readBarCodeAsyncAction =
      AsyncAction('ProductStoreBase.readBarCode', context: context);

  @override
  Future<String> readBarCode() {
    return _$readBarCodeAsyncAction.run(() => super.readBarCode());
  }

  late final _$getImageAsyncAction =
      AsyncAction('ProductStoreBase.getImage', context: context);

  @override
  Future<String> getImage(
      {required ImageSource source, required String barCode}) {
    return _$getImageAsyncAction
        .run(() => super.getImage(source: source, barCode: barCode));
  }

  late final _$getListProductsAsyncAction =
      AsyncAction('ProductStoreBase.getListProducts', context: context);

  @override
  Future<void> getListProducts() {
    return _$getListProductsAsyncAction.run(() => super.getListProducts());
  }

  late final _$ProductStoreBaseActionController =
      ActionController(name: 'ProductStoreBase', context: context);

  @override
  bool checkSingleBarCode({required String barCode}) {
    final _$actionInfo = _$ProductStoreBaseActionController.startAction(
        name: 'ProductStoreBase.checkSingleBarCode');
    try {
      return super.checkSingleBarCode(barCode: barCode);
    } finally {
      _$ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
listProducts: ${listProducts}
    ''';
  }
}

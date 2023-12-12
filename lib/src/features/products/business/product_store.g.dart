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
  Future<String> getImage(ImageSource source) {
    return _$getImageAsyncAction.run(() => super.getImage(source));
  }

  late final _$addImageStorageAsyncAction =
      AsyncAction('ProductStoreBase.addImageStorage', context: context);

  @override
  Future<void> addImageStorage(String path, String identifier) {
    return _$addImageStorageAsyncAction
        .run(() => super.addImageStorage(path, identifier));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}

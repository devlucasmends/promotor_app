// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$stateAtom = Atom(name: 'HomeStoreBase.state', context: context);

  @override
  HomeState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(HomeState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$listProductsAtom =
      Atom(name: 'HomeStoreBase.listProducts', context: context);

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
      AsyncAction('HomeStoreBase._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  late final _$getListProductsAsyncAction =
      AsyncAction('HomeStoreBase.getListProducts', context: context);

  @override
  Future<void> getListProducts() {
    return _$getListProductsAsyncAction.run(() => super.getListProducts());
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  String convertDate(String validate) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.convertDate');
    try {
      return super.convertDate(validate);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
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

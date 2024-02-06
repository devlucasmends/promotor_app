// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<UserModel?>? _$userModelComputed;

  @override
  UserModel? get userModel =>
      (_$userModelComputed ??= Computed<UserModel?>(() => super.userModel,
              name: 'HomeStoreBase.userModel'))
          .value;

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

  late final _$_userModelAtom =
      Atom(name: 'HomeStoreBase._userModel', context: context);

  @override
  UserModel? get _userModel {
    _$_userModelAtom.reportRead();
    return super._userModel;
  }

  @override
  set _userModel(UserModel? value) {
    _$_userModelAtom.reportWrite(value, super._userModel, () {
      super._userModel = value;
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

  late final _$removeItemListAsyncAction =
      AsyncAction('HomeStoreBase.removeItemList', context: context);

  @override
  Future<void> removeItemList(
      {required List<ProductModel> list,
      required int index,
      required String uidTeam}) {
    return _$removeItemListAsyncAction.run(
        () => super.removeItemList(list: list, index: index, uidTeam: uidTeam));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  int convertDate(String validity) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.convertDate');
    try {
      return super.convertDate(validity);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getStringValitade(int differenceDays) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getStringValitade');
    try {
      return super.getStringValitade(differenceDays);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String checkColorValidate(int differenceDays, int redAlert, int yellowAlert) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.checkColorValidate');
    try {
      return super.checkColorValidate(differenceDays, redAlert, yellowAlert);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
listProducts: ${listProducts},
userModel: ${userModel}
    ''';
  }
}

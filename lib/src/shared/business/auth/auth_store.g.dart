// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$stateAtom = Atom(name: 'AuthStoreBase.state', context: context);

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_userModelAtom =
      Atom(name: 'AuthStoreBase._userModel', context: context);

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
      AsyncAction('AuthStoreBase._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  late final _$signInAsyncAction =
      AsyncAction('AuthStoreBase.signIn', context: context);

  @override
  Future<void> signIn({required String email, required String password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(email: email, password: password));
  }

  late final _$signUpAsyncAction =
      AsyncAction('AuthStoreBase.signUp', context: context);

  @override
  Future<void> signUp(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    return _$signUpAsyncAction.run(() => super
        .signUp(name: name, phone: phone, email: email, password: password));
  }

  late final _$userIsLoggedAsyncAction =
      AsyncAction('AuthStoreBase.userIsLogged', context: context);

  @override
  Future<bool> userIsLogged() {
    return _$userIsLoggedAsyncAction.run(() => super.userIsLogged());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}

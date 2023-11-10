// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$isAutentAtom =
      Atom(name: 'AuthStoreBase.isAutent', context: context);

  @override
  bool get isAutent {
    _$isAutentAtom.reportRead();
    return super.isAutent;
  }

  @override
  set isAutent(bool value) {
    _$isAutentAtom.reportWrite(value, super.isAutent, () {
      super.isAutent = value;
    });
  }

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

  late final _$signInAsyncAction =
      AsyncAction('AuthStoreBase.signIn', context: context);

  @override
  Future<void> signIn({required String email, required String password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(email: email, password: password));
  }

  @override
  String toString() {
    return '''
isAutent: ${isAutent},
state: ${state}
    ''';
  }
}

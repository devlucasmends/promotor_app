// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on SettingsStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'SettingsStoreBase.state', context: context);

  @override
  SettingsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SettingsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_initializeAsyncAction =
      AsyncAction('SettingsStoreBase._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  late final _$getUserAsyncAction =
      AsyncAction('SettingsStoreBase.getUser', context: context);

  @override
  Future<UserModel?> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$updatePasswordAsyncAction =
      AsyncAction('SettingsStoreBase.updatePassword', context: context);

  @override
  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) {
    return _$updatePasswordAsyncAction.run(() => super
        .updatePassword(oldPassword: oldPassword, newPassword: newPassword));
  }

  late final _$updateAlarmAsyncAction =
      AsyncAction('SettingsStoreBase.updateAlarm', context: context);

  @override
  Future<void> updateAlarm({required String alert, required int days}) {
    return _$updateAlarmAsyncAction
        .run(() => super.updateAlarm(alert: alert, days: days));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}

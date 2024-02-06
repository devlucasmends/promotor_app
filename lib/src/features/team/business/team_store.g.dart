// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TeamStore on TeamStoreBase, Store {
  Computed<UserModel?>? _$userModelComputed;

  @override
  UserModel? get userModel =>
      (_$userModelComputed ??= Computed<UserModel?>(() => super.userModel,
              name: 'TeamStoreBase.userModel'))
          .value;

  late final _$teamCurrentAtom =
      Atom(name: 'TeamStoreBase.teamCurrent', context: context);

  @override
  TeamModel? get teamCurrent {
    _$teamCurrentAtom.reportRead();
    return super.teamCurrent;
  }

  @override
  set teamCurrent(TeamModel? value) {
    _$teamCurrentAtom.reportWrite(value, super.teamCurrent, () {
      super.teamCurrent = value;
    });
  }

  late final _$_userModelAtom =
      Atom(name: 'TeamStoreBase._userModel', context: context);

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

  late final _$stateAtom = Atom(name: 'TeamStoreBase.state', context: context);

  @override
  TeamState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(TeamState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_initializeAsyncAction =
      AsyncAction('TeamStoreBase._initialize', context: context);

  @override
  Future<void> _initialize() {
    return _$_initializeAsyncAction.run(() => super._initialize());
  }

  late final _$createTeamAsyncAction =
      AsyncAction('TeamStoreBase.createTeam', context: context);

  @override
  Future<void> createTeam() {
    return _$createTeamAsyncAction.run(() => super.createTeam());
  }

  late final _$setTeamAsyncAction =
      AsyncAction('TeamStoreBase.setTeam', context: context);

  @override
  Future<void> setTeam({required String uidTeam}) {
    return _$setTeamAsyncAction.run(() => super.setTeam(uidTeam: uidTeam));
  }

  late final _$getTeamCurrentAsyncAction =
      AsyncAction('TeamStoreBase.getTeamCurrent', context: context);

  @override
  Future<void> getTeamCurrent() {
    return _$getTeamCurrentAsyncAction.run(() => super.getTeamCurrent());
  }

  late final _$removeUserTeamAsyncAction =
      AsyncAction('TeamStoreBase.removeUserTeam', context: context);

  @override
  Future<void> removeUserTeam(
      {required String uidTeam, required String uidUser, required int index}) {
    return _$removeUserTeamAsyncAction.run(() =>
        super.removeUserTeam(uidTeam: uidTeam, uidUser: uidUser, index: index));
  }

  @override
  String toString() {
    return '''
teamCurrent: ${teamCurrent},
state: ${state},
userModel: ${userModel}
    ''';
  }
}

import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/team/business/team_state.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'team_store.g.dart';

class TeamStore = TeamStoreBase with _$TeamStore;

abstract class TeamStoreBase with Store {
  final TeamRepository _teamRepository;
  final AuthRepository _authRepository;

  @observable
  TeamModel? teamCurrent;

  @observable
  UserModel? _userModel;

  @computed
  UserModel? get userModel => _userModel;

  @observable
  TeamState state = TeamInitState();

  TeamStoreBase(this._teamRepository, this._authRepository) {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    await _teamRepository.initialize();
    await _authRepository.initialize();
    _userModel = await _authRepository.userLogged();
  }

  @action
  Future<void> createTeam() async {
    state = TeamLoadingState();
    await _teamRepository.createTeam();
    state = TeamSucessState();
  }

  @action
  Future<void> setTeam({required String uidTeam}) async {
    state = TeamLoadingState();
    await _teamRepository.setTeam(uidTeam: uidTeam);
    state = TeamSucessState();
  }

  @action
  Future<void> getTeamCurrent() async {
    state = TeamLoadingState();
    teamCurrent = await _teamRepository.getTeamCurrent();
    state = TeamSucessState();
  }

  @action
  Future<void> removeUserTeam({
    required String uidTeam,
    required String uidUser,
    required int index,
  }) async {
    state = TeamLoadingState();
    await _teamRepository.removeUserTeam(
      uidTeam: uidTeam,
      uidUser: uidUser,
      index: index,
    );
    state = TeamSucessState();
  }
}

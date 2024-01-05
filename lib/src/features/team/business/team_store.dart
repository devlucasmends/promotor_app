import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/team/business/team_state.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
part 'team_store.g.dart';

class TeamStore = TeamStoreBase with _$TeamStore;

abstract class TeamStoreBase with Store {
  final TeamRepository _teamRepository;
  TeamModel? teamCurrent;

  @observable
  TeamState state = TeamInitState();

  TeamStoreBase(this._teamRepository) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _teamRepository.initialize();
  }

  Future<void> createTeam() async {
    state = TeamLoadingState();
    await _teamRepository.createTeam();
    state = TeamSucessState();
  }

  Future<void> setTeam({required String uidTeam}) async {
    state = TeamLoadingState();
    await _teamRepository.setTeam(uidTeam: uidTeam);
    state = TeamSucessState();
  }

  Future<void> getTeamCurrent() async {
    state = TeamLoadingState();
    teamCurrent = await _teamRepository.getTeamCurrent();
    state = TeamSucessState();
  }

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

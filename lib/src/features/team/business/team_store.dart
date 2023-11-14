import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/team/business/team_state.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
part 'team_store.g.dart';

class TeamStore = TeamStoreBase with _$TeamStore;

abstract class TeamStoreBase with Store {
  final TeamRepository _teamRepository;

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
}

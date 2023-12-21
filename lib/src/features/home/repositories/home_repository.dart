import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class HomeRepository {
  final FirebaseService _firebaseService;

  HomeRepository(this._firebaseService);

  Future<TeamModel> getTeamCurrent() async {
    return await _firebaseService.getTeamCurrent();
  }
}

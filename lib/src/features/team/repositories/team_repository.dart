import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class TeamRepository {
  final FirebaseService _firebaseService;

  TeamRepository(this._firebaseService);

  Future<void> createTeam() async {
    await _firebaseService.createTeam();
  }

  Future<void> setTeam({required String uidTeam}) async {
    await _firebaseService.setTeam(uidTeam: uidTeam);
  }
}

import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class SettingsRepository {
  final FirebaseService _firebaseService;

  SettingsRepository(this._firebaseService);

  Future<UserModel?> getUser() async {
    return await _firebaseService.userLogged();
  }

  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    await _firebaseService.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  Future<void> updateAlarm({required String alert, required int days}) async {
    await _firebaseService.updateAlarm(alarm: alert, days: days);
  }
}

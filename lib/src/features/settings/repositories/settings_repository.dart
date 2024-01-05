import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class SettingsRepository {
  final FirebaseService _firebaseService;

  SettingsRepository(this._firebaseService);

  Future<UserModel?> getUser() async {
    return await _firebaseService.getUser();
  }

  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    await _firebaseService.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}

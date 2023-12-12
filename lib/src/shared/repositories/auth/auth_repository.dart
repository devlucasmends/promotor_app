import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class AuthRepository {
  final FirebaseService _firebaseService;

  AuthRepository(this._firebaseService) {
    initialize();
  }

  Future<void> initialize() async {
    await _firebaseService.initialize();
  }

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseService.signIn(email: email, password: password);
  }

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    await _firebaseService.signUp(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
  }

  Future<UserModel?> userIsLogged() async {
    return await _firebaseService.userIsLogged();
  }
}

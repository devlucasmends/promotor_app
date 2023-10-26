import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class AuthRepository {
  final FirebaseService _firebaseService;

  AuthRepository(this._firebaseService);

  Future<void> initialize() async {
    _firebaseService.initialize();
  }

  Future<void> signIn({required String email, required String password}) {
    return _firebaseService.signIn(email: email, password: password);
  }
}

import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authRepository;

  AuthStoreBase(this._authRepository) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _authRepository.initialize();
  }

  Future<void> signIn({required String email, required String password}) async {
    await _authRepository.signIn(email: email, password: password);
  }

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    await _authRepository.signUp(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}

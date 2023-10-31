import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authRepository;
  // late UserModel user;

  AuthStoreBase(this._authRepository);

  Future<void> login({required String email, required String password}) async {
    await _authRepository.signIn(email: email, password: password);
    print('Passou do login');
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
}

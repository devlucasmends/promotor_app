import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authRepository;
  // late UserModel user;

  AuthStoreBase(this._authRepository);

  UserModel login({required String nome, required String senha}) {
    print('chegou aqui');

    _authRepository.signIn(email: nome, password: senha);

    print(nome);
    print(senha);

    return UserModel(name: nome, password: senha);
  }
}

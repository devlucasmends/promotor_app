import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/shared/business/auth/auth_state.dart';
import 'package:promotor_app/src/shared/exceptions/firebase_exception.dart'
    as fe;
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authRepository;

  @observable
  AuthState state = AuthInitState();

  AuthStoreBase(this._authRepository) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _authRepository.initialize();
  }

  @action
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = AuthLoadingState();
    await _authRepository
        .signIn(email: email, password: password)
        .catchError((error, stackTrace) {
      String errorMessage = 'Erro inesperado, tente novamente.';

      if (error is fe.FirebaseException) errorMessage = error.message;
      state = AuthFailureState(errorMessage: errorMessage);
    }).then((value) {
      if (state is! AuthFailureState) {
        state = AuthSucessState();
      }
    });
  }

  @action
  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    await _authRepository
        .signUp(name: name, phone: phone, email: email, password: password)
        .catchError((error, stackTrace) async {
      String errorMessage = 'Erro inesperado, tente novamente.';
      if (error is fe.FirebaseException) errorMessage = error.message;
      state = AuthFailureState(errorMessage: errorMessage);
    }).then((value) async {
      if (state is! AuthFailureState) {
        state = AuthSucessState();
      }
    });
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}

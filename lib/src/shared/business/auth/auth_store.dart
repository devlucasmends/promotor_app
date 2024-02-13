import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/shared/business/auth/auth_state.dart';
import 'package:promotor_app/src/shared/exceptions/firebase_exception.dart'
    as fe;
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _authRepository;

  @observable
  AuthState state = AuthInitState();

  @observable
  UserModel? _userModel;

  @computed
  UserModel? get userModel => _userModel;

  AuthStoreBase(this._authRepository) {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    state = AuthLoadingState();
    await _authRepository.initialize();
    await getUser();
    state = AuthInitState();
  }

  @action
  Future<void> getUser() async {
    state = AuthLoadingState();
    _userModel = await _authRepository.userLogged();
    state = AuthSucessState();
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
    }).then((value) async {
      if (state is! AuthFailureState) {
        _userModel = await _authRepository.userLogged();
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
    state = AuthLoadingState();
    await _authRepository
        .signUp(name: name, phone: phone, email: email, password: password)
        .catchError((error, stackTrace) async {
      String errorMessage = 'Erro inesperado, tente novamente.';
      if (error is fe.FirebaseException) errorMessage = error.message;
      state = AuthFailureState(errorMessage: errorMessage);
    }).then((value) async {
      if (state is! AuthFailureState) {
        _userModel = await _authRepository.userLogged();
        state = AuthSucessState();
      }
    });
  }

  Future<void> signOut() async {
    state = AuthLoadingState();

    _authRepository.signOut()
      ..then((val) async {
        if (state is! AuthFailureState) {
          _userModel = null;
        }
      })
      ..catchError((error, stackTrace) {
        String errorMessage = 'Erro inesperado. Tente novamente mais tarde.';
        if (error is fe.FirebaseException) errorMessage = error.message;
        state = AuthFailureState(errorMessage: errorMessage);
      });
  }
}

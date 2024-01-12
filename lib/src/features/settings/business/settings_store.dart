import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/settings/business/settings_state.dart';
import 'package:promotor_app/src/features/settings/repositories/settings_repository.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/exceptions/firebase_exception.dart'
    as fe;
part 'settings_store.g.dart';

class SettingsStore = SettingsStoreBase with _$SettingsStore;

abstract class SettingsStoreBase with Store {
  final SettingsRepository _settingsRepository;
  late UserModel userModel;
  bool updateSucess = false;

  @observable
  SettingsState state = SettingsInitState();

  SettingsStoreBase(this._settingsRepository) {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    state = SettingsLoadingState();
    userModel = (await getUser())!;
    state = SettingsSucessState();
  }

  @action
  Future<UserModel?> getUser() async {
    return await _settingsRepository.getUser();
  }

  @action
  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    state = SettingsLoadingState();
    await _settingsRepository
        .updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    )
        .catchError((error, stackTrace) async {
      String errorMessage = 'Erro Inesperado. Tente novamente mais tarde.';
      if (error is fe.FirebaseException) errorMessage = error.message;
      state = SettingsFailureState(errorMessage: errorMessage);
    }).then((value) async {
      if (state is! SettingsFailureState) {
        updateSucess = true;
        state = SettingsSucessState();
      }
    });
  }

  @action
  Future<void> updateAlarm({required String alert, required int days}) async {
    state = SettingsLoadingState();
    await _settingsRepository.updateAlarm(alert: alert, days: days);
    userModel = (await getUser())!;
    state = SettingsSucessState();
  }
}

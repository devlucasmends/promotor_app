import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {}

class SettingsInitState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsSucessState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLoadingState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsFailureState extends SettingsState {
  final String errorMessage;
  SettingsFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [errorMessage];
}

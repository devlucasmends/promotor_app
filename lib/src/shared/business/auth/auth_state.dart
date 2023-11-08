import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthFailureState extends AuthState {
  final String errorMessage;
  AuthFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [];
}

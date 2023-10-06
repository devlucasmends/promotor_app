import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {}

class SplashLoadingState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashFailureState extends SplashState {
  final String errorMessage;
  SplashFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [];
}

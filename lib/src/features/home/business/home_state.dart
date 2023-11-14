import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSucessState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFailureState extends HomeState {
  final String errorMessage;
  HomeFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [];
}

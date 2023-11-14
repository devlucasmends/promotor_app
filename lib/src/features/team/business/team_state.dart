import 'package:equatable/equatable.dart';

abstract class TeamState extends Equatable {}

class TeamInitState extends TeamState {
  @override
  List<Object?> get props => [];
}

class TeamSucessState extends TeamState {
  @override
  List<Object?> get props => [];
}

class TeamLoadingState extends TeamState {
  @override
  List<Object?> get props => [];
}

class TeamFailureState extends TeamState {
  final String errorMessage;
  TeamFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [];
}

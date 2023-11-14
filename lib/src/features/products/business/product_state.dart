import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {}

class ProductInitState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductSucessState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductFailureState extends ProductState {
  final String errorMessage;
  ProductFailureState({this.errorMessage = ''});

  @override
  List<Object?> get props => [];
}

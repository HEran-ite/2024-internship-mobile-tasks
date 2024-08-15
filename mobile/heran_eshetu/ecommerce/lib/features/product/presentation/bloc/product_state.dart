import 'package:equatable/equatable.dart';

import '../../domain/entitity/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductStateEmpty extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateLoaded extends ProductState {
  final Product product;
  const ProductStateLoaded({required this.product});
  @override
  List<Object> get props => [product];
}

class ProductLoadFailure extends ProductState {
  final String message;
  const ProductLoadFailure({required this.message});
  @override
  List<Object> get props => [message];
}

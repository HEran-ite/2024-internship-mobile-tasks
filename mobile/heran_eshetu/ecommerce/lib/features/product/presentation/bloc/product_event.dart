import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {
  final String productId;
  const GetProductEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}

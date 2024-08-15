import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecase/delete_product.dart';
import '../../domain/usecase/get_all_product.dart';
import '../../domain/usecase/get_product.dart';
import '../../domain/usecase/insert_product.dart';
import '../../domain/usecase/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase getProductUsecase;
  final GetAllProductUsecase getAllProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final InsertProductUsecase insertProductUsecase;


  ProductBloc(
      {required this.getProductUsecase,
      required this.getAllProductUsecase,
      required this.updateProductUsecase,
      required this.deleteProductUsecase,
      required this.insertProductUsecase,
      })
      : super(ProductStateEmpty()) {
    on<GetProductEvent>((event, emit) async {
      emit(ProductStateLoading());
      final result = await getProductUsecase.execute(event.productId);
      result.fold(
          (failure) => emit(ProductLoadFailure(message: failure.message)),
          (product) => emit(ProductStateLoaded(product: product)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) {
    return events.debounceTime(duration).flatMap(mapper);
  };
}

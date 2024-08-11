// ignore_for_file: prefer_const_declarations

import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/feature_1/domain/entitity/product.dart';
import 'package:ecommerce/features/feature_1/domain/usecase/get_all_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.mocks.dart';

void main() {
  late GetAllProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetAllProductUsecase(mockProductRepository);
  });


  final tProduct = const Product(
      id: 1,
      name: 'name',
      description: 'description',
      price: 1.0,
      imageUrl: 'imageUrl',
      rating: 'rating',
      category: 'category',
      size: [1, 2, 3]);

  test('should get all products from the repository', () async {
    // Arrange
    when(mockProductRepository.getAllProduct())
        .thenAnswer((_) async => Right(tProduct));

    // Act
    final result = await usecase.execute();

    // Assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.getAllProduct());
    verifyNoMoreInteractions(mockProductRepository);
  });
}

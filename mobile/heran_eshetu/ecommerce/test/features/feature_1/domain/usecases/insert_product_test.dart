// ignore_for_file: prefer_const_declarations

import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/feature_1/domain/entitity/product.dart';
import 'package:ecommerce/features/feature_1/domain/usecase/insert_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.mocks.dart';

void main() {
  late InsertProductUsecase usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = InsertProductUsecase(mockProductRepository);
  });

  final tProductId = 1;
  final tProduct = const Product(
      id: 1,
      name: 'name',
      description: 'description',
      price: 1.0,
      imageUrl: 'imageUrl',
      rating: 'rating',
      category: 'category',
      size: [1, 2, 3]);

  test('should get product from the repository', () async {
    // Arrange
    when(mockProductRepository.insertProduct(any))
        .thenAnswer((_) async => Right(tProduct));

    // Act
    final result = await usecase.execute(id: tProductId);

    // Assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.insertProduct(tProductId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}

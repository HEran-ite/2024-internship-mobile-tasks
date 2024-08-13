import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/exceptions.dart';
import 'package:ecommerce/core/error/failures.dart';
import 'package:ecommerce/core/platform/network_info.dart';
import 'package:ecommerce/features/product/data/datasources/local_data_resource.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce/features/product/data/model/product_model.dart';
import 'package:ecommerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final testId = 1;
  const testProduct = ProductModel(
    id: 1,
    name: 'name',
    description: 'description',
    price: 1.0,
    imageUrl: 'imageUrl',
    rating: 'rating',
    category: 'category',
    size: [1, 2, 3],
  );

  group('getProduct', () {
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      await repository.getProduct(testId);

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.getProduct(testId))
              .thenAnswer((_) async => testProduct);

          // Act
          final result = await repository.getProduct(testId);

          // Assert
          verify(mockRemoteDataSource.getProduct(testId));
          expect(result, equals(Right(testProduct)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // Arrange
          when(mockRemoteDataSource.getProduct(testId))
              .thenAnswer((_) async => testProduct);

          // Act
          await repository.getProduct(testId);

          // Assert
          verify(mockRemoteDataSource.getProduct(testId));
          verify(mockLocalDataSource.cacheProduct(testProduct));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(mockRemoteDataSource.getProduct(testId))
              .thenThrow(ServerException());

          // Act
          final result = await repository.getProduct(testId);

          // Assert
          verify(mockRemoteDataSource.getProduct(testId));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // Arrange
          when(mockLocalDataSource.getLastProduct())
              .thenAnswer((_) async => testProduct);

          // Act
          final result = await repository.getProduct(testId);

          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastProduct());
          expect(result, equals(Right(testProduct)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // Arrange
          when(mockLocalDataSource.getLastProduct())
              .thenThrow(CacheException());

          // Act
          final result = await repository.getProduct(testId);

          // Assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastProduct());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}

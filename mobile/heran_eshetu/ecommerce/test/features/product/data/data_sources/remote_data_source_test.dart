import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/error/exceptions.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce/features/product/domain/entitity/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });
  const int testId = 1;
  group('get current product', () {
    test('should return the product model when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProductById(testId))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummy_data/dummy_product_response.json'), 200));
      //act
      final result = await productRemoteDataSourceImpl.getProduct(testId);
      //assert
      expect(result, isA<Product>());
    });

    test('should throw server exception error when the response code is 404',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProductById(testId))))
          .thenAnswer((_) async => http.Response('Not found', 404));
      //act
      final result = productRemoteDataSourceImpl.getProduct(testId);
      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}

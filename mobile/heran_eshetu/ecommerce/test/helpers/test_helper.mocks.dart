import 'package:ecommerce/core/platform/network_info.dart';
import 'package:ecommerce/features/product/data/datasources/local_data_resource.dart';
import 'package:ecommerce/features/product/data/datasources/remote_data_source.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    NetworkInfo,
    ProductLocalDataSource,
    InternetConnectionChecker,
    
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}

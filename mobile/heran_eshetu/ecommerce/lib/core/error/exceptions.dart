class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Server Error'});
}

class CacheExeption implements Exception{
  final String message;
  CacheExeption({this.message = 'Cache Error'});
}

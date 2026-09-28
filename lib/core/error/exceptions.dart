

class ServerException implements Exception {
  final String error;

  ServerException({required this.error});
}

//route
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}



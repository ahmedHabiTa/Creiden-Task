class ServerException implements Exception {
  String message;
  ServerException({required this.message});
}

class CacheException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}

class NoteException implements Exception {
  String message;
  NoteException({required this.message});
}

class NoCachedUserException implements Exception {}

class CacheUserAcssesToken implements Exception {}
